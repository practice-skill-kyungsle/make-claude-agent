# make-claude-agent

Claude Code용 멀티 에이전트 개발 시스템. PLAN 기반 TDD 워크플로우를 통해 AI-인간 협업을 구조화합니다.

## 개요

```
요구사항 → PLAN.md → 구현 (TDD) → 아카이브
```

요구사항(파일 또는 직접 입력)을 제공하면, AI 에이전트들이 협업하여 계획을 수립하고 TDD로 구현합니다.

## 빠른 시작

```bash
# 1. 프로젝트에 복사
cp -r .claude /your-project/

# 2. 계획 생성
/make-plan "사용자 인증 기능 구현: 로그인, 회원가입, JWT 토큰"
# 또는 파일 지정
/make-plan requirements.md

# 3. 구현 시작 (마일스톤 끝까지 자동 진행)
/run-plan
```

## 워크플로우

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│  요구사항    │ ──▶ │  /make-plan │ ──▶ │  PLAN.md    │
│ (파일/텍스트)│     │             │     │  (구조화)   │
└─────────────┘     └─────────────┘     └─────────────┘
                           │
                           ▼
                    ┌─────────────┐
                    │ Strategy AI │ ◀──┐
                    │  (설계자)    │    │ 피드백
                    └─────────────┘    │ 반복
                           │           │
                           ▼           │
                    ┌─────────────┐    │
                    │   Sub AI    │ ───┘
                    │  (검증자)    │
                    └─────────────┘
                           │ 승인
                           ▼
                    ┌─────────────┐
                    │  /run-plan  │
                    └─────────────┘
                           │
                           ▼
                    ┌─────────────┐
                    │   Main AI   │ ◀──┐
                    │  (구현자)    │    │ 마일스톤
                    └─────────────┘ ───┘ 연속 실행
                           │
                           ▼
                    ┌─────────────┐
                    │   아카이브   │
                    │doc/projects │
                    └─────────────┘
```

## 에이전트

| 에이전트 | 역할 | 담당 업무 |
|----------|------|-----------|
| **Strategy AI** | 설계자 | 요구사항 → PLAN.md 변환, 마일스톤 정의 |
| **Sub AI** | 검증자 | PLAN.md 검토, Critical/Important/Suggestion 피드백 |
| **Main AI** | 구현자 | TDD로 마일스톤 순차 실행, 막힐 때까지 연속 진행 |

## 스킬 (슬래시 커맨드)

| 커맨드 | 설명 |
|--------|------|
| `/make-plan [요구사항]` | 요구사항(파일 또는 텍스트)으로 PLAN.md 생성 |
| `/run-plan` | PLAN.md의 마일스톤을 TDD로 구현 (완료 시 아카이브) |
| `/dev-workflow` | 개발 방법론 가이드 참조 |

## PLAN.md 구조

```markdown
# Implementation Plan: 프로젝트명

## Overview
한 문단 요약 (목표, 범위, 예상 기간)

## Milestones Overview
Progress: [=====>              ] 25%

M0: ████████████████████ 100% ✅ Setup
M1: ██████░░░░░░░░░░░░░░  30% 🔄 Feature A
M2: ░░░░░░░░░░░░░░░░░░░░   0% ⬜ Feature B

## Milestones

### M1: Feature A
**Status**: In Progress
**Duration**: 1-3시간
**Dependencies**: M0

**Sub-tasks**:
- [x] 1.1 - 테스트 작성
- [ ] 1.2 - 구현

**완료 기준**:
- 테스트 통과
- 100줄 이내 변경

## Session Notes
(구현 시 자동 기록)
```

## TDD 사이클

```
Red (실패 테스트) → Green (최소 구현) → Refactor (개선)
```

- 테스트 먼저 작성
- 최소 구현으로 통과
- 리팩토링 (테스트 유지)
- **100줄 이내** 변경 원칙

## 피드백 등급 (Sub AI)

| 등급 | 의미 | 처리 |
|------|------|------|
| 🔴 **Critical** | 반드시 수정 | 승인 불가 |
| 🟡 **Important** | 수정 권장 | 1개까지 허용 |
| 🟢 **Suggestion** | 선택적 개선 | 제한 없음 |

## 마일스톤 가이드라인

**적절한 크기**:
- 1-3시간 작업량
- 100-300줄 코드
- 독립적 테스트 가능

**분할 예시**:
- ❌ "사용자 인증 시스템"
- ✅ M1: 데이터 모델 (1시간)
- ✅ M2: 회원가입 API (1.5시간)
- ✅ M3: 로그인 API (1.5시간)

## 연속 실행 및 아카이브

Main AI는 마일스톤 완료 후 **자동으로 다음 마일스톤을 진행**합니다.

**중단 조건**:
- 🎉 모든 마일스톤 완료 → `doc/projects/`로 아카이브
- 🚧 막힘 발생 (30분 이상 진전 없음)
- ❌ 테스트 실패 해결 불가

**아카이브**:
- 완료된 PLAN.md는 `doc/projects/[프로젝트명]-YYYYMMDD.md`로 이동
- 프로젝트 이력 관리 및 새 프로젝트 시작 가능

## 디렉토리 구조

```
.claude/
├── agents/
│   ├── main-ai/
│   │   └── main-ai.md      # 구현자 에이전트
│   ├── sub-ai/
│   │   └── sub-ai.md       # 검증자 에이전트
│   └── strategy-ai/
│       └── strategy-ai.md  # 설계자 에이전트
└── skills/
    ├── dev-workflow/
    │   └── SKILL.md        # 개발 방법론
    ├── make-plan/
    │   └── SKILL.md        # /make-plan 커맨드
    └── run-plan/
        └── SKILL.md        # /run-plan 커맨드

doc/
└── projects/               # 완료된 PLAN 아카이브
    ├── auth-system-20250126.md
    └── api-redesign-20250115.md
```

## 라이선스

MIT
