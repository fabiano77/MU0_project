# MU0_project
The project of digital systems design courses in college.<br/>

Designing the MU0 processor to verify the instruction set and perform tasks.<br/>

## Tool
- ModelSim (wave simulation)
- Quartus II (synthesis)

---
## synthesis result
### MU0 processor 
![synthesis](https://github.com/fabiano77/MU0_project/blob/main/sim_result/sim_MU0_synthesis.png?raw=true)

---
## simulation wave
### <b> 1) verification code</b>
모든 명령어셋이 정상적으로 동작하는지 검증하기 위한 code
![verification코드](https://github.com/fabiano77/MU0_project/blob/main/sim_result/verification_code.png?raw=true)
![verification파형1](https://github.com/fabiano77/MU0_project/blob/main/sim_result/sim_wave_verification_%EC%9B%90%EB%B3%B8.png?raw=true)
![verification파형2](https://github.com/fabiano77/MU0_project/blob/main/sim_result/sim_wave_verification_%EC%84%A4%EB%AA%85.png?raw=true)

### <b>2) task code </b>
Task는 수열 S, S+1, ... N까지의 합을 구하는 것입니다.</br>
수식으로는 ∑ n = S+(S+1)+(S+2)+ … +(N-1)+N 으로 S부터 N까지 모두 더한 것을 구하는 것입니다.</br>
테스트 벤치에서는 S가 15이고 N이 21이므로 15+16+17+18+19+20+21 을 차례대로 ACC에 더하고 끝내는 동작을 해야합니다.


![task코드](https://github.com/fabiano77/MU0_project/blob/main/sim_result/task_tb.png?raw=true)
![task파형1](https://github.com/fabiano77/MU0_project/blob/main/sim_result/sim_wave_task_%EC%9B%90%EB%B3%B8.png?raw=true)
![task파형2](https://github.com/fabiano77/MU0_project/blob/main/sim_result/sim_wave_task_1.png?raw=true)
파형을 보면 예상했던 동작을 잘 수행하므로 올바르게 설계되었다는 것을 확인할 수 있습니다.