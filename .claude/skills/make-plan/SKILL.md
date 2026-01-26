---
name: make-plan
description: 요구사항을 읽고 PLAN.md를 생성합니다. 파일 경로 또는 직접 텍스트 입력 지원.
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, Bash, Task, WebSearch
---

# 즉시 실행: 요구사항 → PLAN.md 생성

## 지금 바로 수행할 것:

1. **요구사항 확인**
   - 인자가 있으면 요구사항으로 사용 (파일 경로든 텍스트든)
   - 인자 없으면 "요구사항을 입력해주세요" 안내 후 중단

2. **Task tool로 strategy-ai 에이전트 호출**
   ```
   Task(
     subagent_type: "strategy-ai",
     description: "Create PLAN.md from requirements",
     prompt: "다음 요구사항을 읽고 PLAN.md를 생성하세요.

     📄 요구사항:
     [입력된 내용 전달]

     🎯 작성 지침:
     - dev-workflow skill의 PLAN.md 템플릿 사용
     - 8-10개 마일스톤으로 분할
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