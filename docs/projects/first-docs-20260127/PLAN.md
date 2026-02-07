# Implementation Plan: Multi-AI Collaboration System

## Overview

3개의 에이전트와 1개의 스킬을 생성하여 Multi-AI 협업 시스템 구현

**목표**: 어디서든 공용으로 사용 가능한 글로벌 에이전트/스킬 시스템

---

## Architecture

```
~/.claude/
├── agents/
│   ├── strategy-ai/
│   │   └── strategy-ai.md      # 전략가 AI (TECHSPEC, PLAN 설계)
│   ├── main-ai/
│   │   └── main-ai.md          # 메인 AI (코드 구현)
│   └── sub-ai/
│       └── sub-ai.md           # 서브 AI (검증/피드백)
└── skills/
    └── dev-workflow/
        ├── SKILL.md            # 개발 방법론 스킬 (진입점)
        └── methodology.md      # 상세 가이드 (참조용)
```

---

## File Specifications

### 1. Strategy AI Agent (`~/.claude/agents/strategy-ai/strategy-ai.md`)

**역할**: TECHSPEC & PLAN 설계자

**핵심 기능**:
- 사용자 요구사항 → 구조화된 TECHSPEC 변환
- 실행 가능한 PLAN.md 작성
- Sub AI와 협업하여 계획 검증

**압축 전략**: 1833줄 → ~200줄
- 핵심 원칙만 유지
- 템플릿/예시 간소화
- 체크리스트 통합

**Frontmatter**:
```yaml
---
name: strategy-ai
description: Project architect that designs TECHSPEC and PLAN documents. Use when starting new projects or planning major features.
tools: Read, Glob, Grep, Write, Edit, Bash, Task, WebSearch
model: inherit
skills:
  - dev-workflow
---
```

### 2. Main AI Agent (`~/.claude/agents/main-ai/main-ai.md`)

**역할**: 구현 담당자

**핵심 기능**:
- TECHSPEC 요구사항을 코드로 구현
- TDD 사이클 준수 (Red → Green → Refactor)
- PLAN.md 마일스톤 실행
- 100줄 이내 변경 원칙

**압축 전략**: 1296줄 → ~150줄
- TDD 사이클 핵심만
- 워크플로우 간소화
- 품질 체크리스트 통합

**Frontmatter**:
```yaml
---
name: main-ai
description: Code implementer that executes PLAN milestones using TDD. Use when implementing features defined in TECHSPEC.
tools: Read, Glob, Grep, Write, Edit, Bash, TodoWrite
model: inherit
skills:
  - dev-workflow
---
```

### 3. Sub AI Agent (`~/.claude/agents/sub-ai/sub-ai.md`)

**역할**: 검증 & 피드백 담당자

**핵심 기능**:
- TECHSPEC/PLAN 검증
- 구현 계획 리뷰
- Critical/Important/Nice-to-have 피드백
- 합의 도달까지 반복 검토

**압축 전략**: 845줄 → ~150줄
- 피드백 템플릿 간소화
- 검증 프로세스 핵심만
- 체크리스트 통합

**Frontmatter**:
```yaml
---
name: sub-ai
description: Critical peer that validates TECHSPEC, PLAN, and implementation plans. Use for code review and quality assurance.
tools: Read, Glob, Grep
model: inherit
permissionMode: plan
skills:
  - dev-workflow
---
```

### 4. Dev Workflow Skill (`~/.claude/skills/dev-workflow/SKILL.md`)

**역할**: 개발 방법론 가이드

**핵심 내용**:
- TECHSPEC → PLAN → 구현 워크플로우
- TDD 원칙
- 마일스톤 관리
- 세션 관리

**압축 전략**: 774줄 → ~150줄 (SKILL.md) + ~100줄 (methodology.md)
- 핵심 개념만 SKILL.md에
- 상세 가이드는 별도 파일 참조

**Frontmatter**:
```yaml
---
name: dev-workflow
description: Development workflow methodology using TECHSPEC and PLAN documents for structured AI-human collaboration
user-invocable: true
allowed-tools: Read, Glob, Grep, Write, Edit, TodoWrite
---
```

---

## Implementation Steps

### Milestone 0: Setup (~5분) ✅
- [x] 0.1 - 프로젝트 agents 디렉토리 생성
- [x] 0.2 - 프로젝트 skills 디렉토리 생성

### Milestone 1: Dev Workflow Skill (~15분) ✅
- [x] 1.1 - SKILL.md 작성 (핵심 워크플로우)

### Milestone 2: Strategy AI Agent (~15분) ✅
- [x] 2.1 - strategy-ai.md 작성
- [x] 2.2 - PLAN 작성 가이드 포함

### Milestone 3: Main AI Agent (~15분) ✅
- [x] 3.1 - main-ai.md 작성
- [x] 3.2 - TDD 사이클 및 구현 가이드 포함

### Milestone 4: Sub AI Agent (~15분) ✅
- [x] 4.1 - sub-ai.md 작성
- [x] 4.2 - 검증/피드백 프로세스 포함

### Milestone 5: Testing (~20분) ✅
- [x] 5.1 - 파일 구조 검증
- [x] 5.2 - 에이전트 문법 검증
- [x] 5.3 - Task tool 테스트 (built-in 에이전트)

---

## Testing Strategy

### Test 1: Skill Invocation
```
사용자: /dev-workflow 설명해줘
기대: dev-workflow 스킬이 로드되고 개발 방법론 설명
```

### Test 2: Strategy AI Agent
```
사용자: strategy-ai 에이전트를 사용해서 "사용자 인증 시스템" TECHSPEC 초안을 작성해줘
기대: Task tool로 strategy-ai 서브에이전트 실행, TECHSPEC 구조 생성
```

### Test 3: Main AI Agent
```
사용자: main-ai 에이전트로 간단한 함수 구현해줘
기대: Task tool로 main-ai 서브에이전트 실행, TDD 사이클 준수
```

### Test 4: Sub AI Agent
```
사용자: sub-ai 에이전트로 이 코드 리뷰해줘
기대: Task tool로 sub-ai 서브에이전트 실행, Critical/Important/Nice-to-have 피드백
```

### Test 5: Integration
```
사용자: strategy-ai로 계획하고, sub-ai로 검증해줘
기대: 두 에이전트가 순차적으로 실행되어 협업
```

---

## Verification Checklist

- [ ] `~/.claude/skills/dev-workflow/SKILL.md` 존재 확인
- [ ] `~/.claude/agents/strategy-ai/strategy-ai.md` 존재 확인
- [ ] `~/.claude/agents/main-ai/main-ai.md` 존재 확인
- [ ] `~/.claude/agents/sub-ai/sub-ai.md` 존재 확인
- [ ] `/dev-workflow` 명령어 실행 가능
- [ ] 각 에이전트가 Task tool로 호출 가능
- [ ] 에이전트들이 dev-workflow 스킬 참조 가능

---

## Critical Files

**생성할 파일**:
1. `C:\Users\user\.claude\skills\dev-workflow\SKILL.md`
2. `C:\Users\user\.claude\skills\dev-workflow\methodology.md`
3. `C:\Users\user\.claude\agents\strategy-ai\strategy-ai.md`
4. `C:\Users\user\.claude\agents\main-ai\main-ai.md`
5. `C:\Users\user\.claude\agents\sub-ai\sub-ai.md`

**참조 문서** (이 레포):
- `STRATEGY_AI_GUIDE.md` → strategy-ai 에이전트
- `MAIN_AI_GUIDE.md` → main-ai 에이전트
- `CO_AI_GUIDE.md` → sub-ai 에이전트
- `PROJECT_GUIDE.md` → dev-workflow 스킬

---

---

## Usage Guide

### 스킬 사용
```bash
# 이 프로젝트 디렉토리에서 Claude Code 실행
cd make-claude-agent
claude

# 스킬 확인
/skills

# 스킬 호출
/dev-workflow
```

### 에이전트 사용
```bash
# 에이전트 확인
/agents

# 에이전트 선택해서 사용
# (Claude Code가 자동으로 적절한 에이전트 선택)
```

### 글로벌 사용 (모든 프로젝트)
```bash
# .claude 폴더를 글로벌 위치로 복사
cp -r .claude/* ~/.claude/

# 이제 어디서든 사용 가능
```

---

## Notes

### Best Practices Applied

1. **Progressive Disclosure**: SKILL.md는 핵심만, 상세는 별도 파일 참조
2. **Token Efficiency**: 원본 문서 압축 (평균 85% 감소)
3. **Global Scope**: `~/.claude/`에 배치하여 모든 프로젝트에서 사용 가능
4. **Skill Preloading**: 에이전트들이 dev-workflow 스킬을 자동 로드
5. **Permission Isolation**: sub-ai는 read-only (plan mode)

### Sources

- [Claude Code Skills Documentation](https://code.claude.com/docs/en/skills)
- [Claude Code Subagents Documentation](https://code.claude.com/docs/en/sub-agents)
- [Agent SDK Overview](https://platform.claude.com/docs/en/agent-sdk/overview)
