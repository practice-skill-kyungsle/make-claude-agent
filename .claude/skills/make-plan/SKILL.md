---
name: make-plan
description: TODO.md를 읽고 PLAN.md를 생성합니다.
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, WebSearch
---

# 즉시 실행: TODO.md → PLAN.md 생성

## 지금 바로 수행할 것:

1. **Read tool로 TODO.md 읽기**
   - 파일이 없으면 사용자에게 "TODO.md를 먼저 작성해주세요" 안내 후 중단

2. **Task tool로 strategy-ai 에이전트 호출**
   ```
   Task(
     subagent_type: "strategy-ai",
     description: "Create PLAN.md from TODO.md",
     prompt: "TODO.md를 읽고 PLAN.md를 생성하세요.

     📄 TODO.md 내용:
     [TODO.md 전체 내용 전달]

     🎯 요구사항:
     - dev-workflow skill의 PLAN.md 템플릿 사용
     - TODO.md 내용을 8-10개 마일스톤으로 분할
     - 각 마일스톤 1-3시간 크기로 설정
     - 의존성 명시
     - sub-ai 에이전트로 검토 받고 승인받을 것

     ✅ 완료 조건:
     - PLAN.md 파일 생성 완료
     - sub-ai 승인 완료"
   )
   ```

3. **완료 안내**
   - "PLAN.md 생성 완료. `/run-plan`으로 구현을 시작하세요."