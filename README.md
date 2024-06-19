# Poomy Database

- 일단 개발할 때 진행할 데이터베이스
- FK 설정을 일단 해놓긴 했는데, 추후에 삭제할 수도 있음

## 방법
[Poomy 개발팀 DB 설정 페이지](https://www.notion.so/DB-25e005431b89405c8e222f9c9d2ec952)
에 들어가서 `docker-compose.yml` 파일을 해당 레포에 생성

docker-compose 실행
```bash
docker-compose up -d
```
컨테이너 시작
```bash
docker start poomy-container
```
처음에만 위와 같이 시작하고 `Docker Desktop` 설치해서 관리!!!

Docker을 켜놓은 상태에서 `MySQLWokrbench` 또는 `DataGrip` 접속해서 Docker와 연결 진행

설정 관련된 부분은 [Poomy 개발팀 DB 설정 페이지](https://www.notion.so/DB-25e005431b89405c8e222f9c9d2ec952) 참고

## SQL 실행
1. 위 설정이 끝났다면, `MySQLWokrbench` 또는 `DataGrip`에서 `create.sql` 파일을 실행한다.
2. 테스트 데이터는 추후에 삽입할 예정... 아직 작업 못함ㅠㅠ