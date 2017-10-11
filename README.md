# Distributed-BitCoin-Miner
An Elixir CLI application to generate bitcoins in a distributed system

## Group Members: 
1. Jahin Majumdar(UFID 69139840)
2. Spandita Gujrati (UFID 81858145)

## 1. Size of Work Unit: 
We have used number of actors = (No. of cores in the machine*2)+2 for the most effective usage. <br />
Each worker gets equal of of work at every instant. The size of our work unit is determined by regulating the actors and determining the ideal distribution of subproblems for a fixed number of workers. The bitcoins are mined continuously by workers which are supervised by a boss to keep track of the process. Even as separate machines are added as workers, the work size is distributed equally. 

## 2. Results for k = 4 (first 5 results included)
1. jahinm;YKEtB     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;00003280EA1C97257B873A7BB07801B2223A1869A3BB4B6B7A95E923F813521B
2. jahinm;cPJrP     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0000F962592026C0F69971EAF997E28A58EA2F3243EB161986D0D31C93F6A632
3. jahinm;nRwNN     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0000F649409F5AB5BC4D8F8CB2DA7C4B70E0E4FC9A2243E72D9E79BF51BD0626
4. jahinm;WYXsi     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0000AB630B4E4B4B1628C67C7BCB870AB8391698BC44C80EE0A67ADA68B0F842
5. jahinm;v05XY     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;000068384E096869A8A651A56E838C6E3316BBBB447735E9C427831C9925D49B

## 3. Running time for k = 5 (4-core machine)

1. **real** 1m3.688s
2. **user** 2m55.792s
3. **sys**  0m45.779s
4. **Ratio of (user+sys)/real** = ~3.48

## 4. Coin with max k = 6      
jahinm;KSTtV     &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0000003622C22D62B58FCC29C6DBB8A04F1158945EF3FB5EF2B7E0F3DC0AF7A8

## 5. Largest Number of working machines used to run code: 4

## 6. Note: 
We have included a hack for Windows machines to make sure they pick up the correct IP address instead of locaclhost.
