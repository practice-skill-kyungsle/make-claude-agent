---
name: run-plan
description: PLAN.md를 읽고 마일스톤을 TDD로 구현합니다.
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, TodoWrite
---

# 즉시 실행: PLAN.md 마일스톤 구현

## 지금 바로 수행할 것:

1. **Read tool로 PLAN.md 읽기**
   - 파일이 없으면 "`/make-plan`을 먼저 실행해주세요" 안내 후 중단

2. **다음 마일스톤 찾기**
   - Status가 "Not Started" 또는 "In Progress"인 첫 마일스톤
   - 모두 완료 시 "🎉 프로젝트 완료!" 축하 메시지 후 중단

3. **Task tool로 main-ai 에이전트 호출**
   ```
   Task(
     subagent_type: "main-ai",
     description: "Implement milestone M[N] with TDD",
     prompt: "PLAN.md의 다음 마일스톤을 TDD로 구현하세요.

     📄 PLAN.md 내용:
     [PLAN.md 전체 내용 전달]

     🎯 현재 마일스톤: M[N] - [마일스톤명]

     ✅ 요구사항:
     - TDD 사이클 준수 (Red → Green → Refactor)
     - 테스트 먼저 작성
     - 100줄 이내 변경
     - PLAN.md 업데이트 (서브태스크 체크, Session Notes)
     - 커밋: feat(M[N]): [설명]

     📋 완료 기준:
     - 모든 테스트 통과
     - PLAN.md 업데이트 완료
     - 커밋 완료"
   )
   ```

4. **연속 진행** (막히지 않는 한 자동 반복)
   - 마일스톤 완료 후 **즉시 다음 마일스톤으로 진행**
   - 사용자에게 묻지 않고 계속 실행
   - 중단 조건:
     - 🎉 모든 마일스톤 완료 → 아카이브 후 축하 메시지
     - 🚧 막힘 발생 → 문제 상황 보고 후 사용자 입력 대기
     - ❌ 테스트 실패 해결 불가 → 상황 보고 후 대기

5. **아카이브** (모든 마일스톤 완료 시)
   - `docs/projects/` 폴더 없으면 생성
   - PLAN.md에서 프로젝트명 추출 (`# Implementation Plan: [프로젝트명]`)
   - 파일 이동: `PLAN.md` → `docs/projects/[프로젝트명]-YYYYMMDD.md`
   - 완료 메시지:
     ```
     🎉 프로젝트 완료!
     📦 PLAN이 아카이브되었습니다: docs/projects/[프로젝트명]-YYYYMMDD.md
     ```