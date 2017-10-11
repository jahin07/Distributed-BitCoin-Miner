defmodule Server do
    def mine do
      {:ok, addrs} = :inet.getif
      {inner_addrs, _, _} = Enum.at(addrs,0)
      {first, second, third, fourth} = inner_addrs
      ip = "#{first}.#{second}.#{third}.#{fourth}"

      #hack for windows ip address
      if ip == "127.0.0.1" do
        {:ok, addrs}= :inet.getif
        sec = Enum.at(addrs,1)
        {inner_addrs, _, _} = sec
        {first, second, third, fourth} = inner_addrs
        ip = "#{first}.#{second}.#{third}.#{fourth}"
      end

      server = "bitcoinserver@#{ip}"
      server_atom = String.to_atom(server)
      Node.start(server_atom)
      Node.set_cookie(Node.self(), :"mycookie")
    end

  def loop do
    receive do
      {k} -> check(k)
    end
    loop
  end

  def loop1 do
    receive do
      {:message, k} -> Server.testing(k,0)
    end
  end

  def testing(k,size) do
    s = Kernel.length(Node.list)
      if s - size>0 do
        diff = s - size
        conn_dif(Node.list, size, diff, k)
      end
    testing(k,s)
  end

  def conn_dif(list, s, diff, k) do
    if diff != 0 do
      n = Enum.at(list, s+diff-1)
      pid1 = Node.spawn(n, Worker, :loop, [8])
      send pid1, {:message, k}
      conn_dif(list, s, diff-1, k)
    end
  end
    
  def check(k) do
    inp = :crypto.strong_rand_bytes(5) |> Base.encode64 |> binary_part(0,5) #Random string length = 5
    str = Enum.join(["jahinm", inp], ";")
    hash = Base.encode16(:crypto.hash(:sha256, str))
    c = String.to_integer(k) # String.pad_leading("",k,"0")
    l2 = String.slice(hash,0..c-1) |> String.to_charlist |> Server.check_zeros
    if l2 == true do
      #{:ok, file} = File.open("newfile.txt", [:append])
      #IO.binwrite(file, "#{str} \t #{hash}\n")
      IO.puts "#{str} \t #{hash}"
    end
  end

  def check_zeros(list) do
    Enum.all?(list, fn x -> x == 48 end)
  end

  def infloop(k) do
    core = System.schedulers_online
    total = (core*2)+2
    pids = Enum.map(1..total, fn (_) -> spawn(&Server.loop/0) end)
    Enum.each pids, fn pid -> 
      recur(pid, k)
    end
  end

  def recur(pid, k) do
    send(pid, {k})
    recur(pid, k)
  end
end


defmodule Worker do
    def loop(k)  do
        receive do
            {:message, k} -> actor_gen(k)
        end   
    end

    def internal_loop(k) do
        receive do
            {pid, k} -> check(pid, k)
        end
        internal_loop(k)
    end

    def actor_gen(k) do
        core = System.schedulers_online
        total = (core*2)+2
        pids = Enum.map(1..total, fn (_) -> Node.spawn(Node.self, Worker, :internal_loop, [k]) end)
        Enum.each pids, fn pid ->
            recur(pid,k)
        end
    end

    def recur(pid, k) do
      send(pid, {k})
      recur(pid, k)
    end

    def check(pid, k) do
        inp = :crypto.strong_rand_bytes(5) |> Base.encode64 |> binary_part(0,5) #Random string length = 5
        str = Enum.join(["jahinm", inp], ";")
        hash = Base.encode16(:crypto.hash(:sha256, str))
        l2 = String.slice(hash,0..k-1) |> String.to_charlist |> Worker.check_zeros
        if l2 == true do
            IO.puts "#{str} \t #{hash}"   
        end
    end

    def check_zeros(list) do
        Enum.all?(list, fn x -> x == 48 end)
    end

    def dummy do
        dummy()
    end

    def main(server_ip) do
        {:ok, addrs} = :inet.getif
        {inner_addrs, _, _} = Enum.at(addrs,0)
        {first, second, third, fourth} = inner_addrs
        ip = "#{first}.#{second}.#{third}.#{fourth}"

        #hack for windows ip address
      if ip == "127.0.0.1" do
        {:ok, addrs}= :inet.getif
        sec = Enum.at(addrs,1)
        {inner_addrs, _, _} = sec
        {first, second, third, fourth} = inner_addrs
        ip = "#{first}.#{second}.#{third}.#{fourth}"
      end

        worker = "bitcoinworker@#{ip}"
        worker_atom = String.to_atom(worker)

        server = "bitcoinserver@#{server_ip}"
        server_atom = String.to_atom(server)

        Node.start(worker_atom)
        Node.set_cookie(Node.self(), :"mycookie")
        Node.connect(server_atom)
        dummy()
    end
end

defmodule Project1 do
  def main(args) do

    if List.first(args) =~ "." == true do
        Worker.main(List.first(args))
    else
      Server.mine
      escape = String.length(List.first(args))
      k_s = String.slice(List.first(args),0..escape-1) #for \n 
      c = String.to_integer(k_s)
      pid1 = spawn(&Server.loop1/0)
      send pid1, {:message, c}
      Server.infloop(List.first(args)) #local in file
    end 
  end
end