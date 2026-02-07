# 개발 가이드: TechSpec & PLAN 기반 워크플로우

> 이 문서는 AI 코딩 에이전트(Claude Code, Codex 등)와 인간 개발자가 함께 읽고 따라야 하는 개발 방법론을 설명합니다.

---

## 개요

### 이 방법론을 사용하는 이유

**문제**: AI 에이전트에게 "이 기능 구현해줘"라고 하면

- 방향을 잃고 헤맴
- 불필요한 코드를 대량 생성
- 요구사항을 제대로 이해하지 못함
- 작업 진행상황 추적 불가

**해결**: 체계적인 문서화로 AI와 인간이 같은 목표를 향해 협업

- ✅ 명확한 목표와 범위 정의
- ✅ 단계별 실행 계획
- ✅ 진행상황 추적 가능
- ✅ 누구든 프로젝트에 즉시 투입 가능

### 핵심 원칙

[\*\*TECHSPEC.md](http://techspec.md/) (무엇을) → [PLAN.md](http://plan.md/) (어떻게) → 구현 (실행)\*\*

- 전략 (2일) → 전술 (3시간) → 실행 (마일스톤별)

---

## 핵심 개념

### 1. [TECHSPEC.md](http://techspec.md/) (기술 명세서)

**역할**: PM이 작성하는 요구사항 문서
**질문**: "무엇을(What) 만들어야 하는가?"
**독자**: 프로젝트에 참여하는 모든 사람 (AI 포함)

**포함 내용**:

- 목표와 비목표 (Goals / Non-Goals)
- 현재 상태 분석
- 아키텍처 설계
- 기능 요구사항 (구체적으로)
- 비기능 요구사항 (성능, 확장성 등)
- 구현 세부사항 (코드 스켈레톤 포함)

**특징**:

- 3만 토큰 이상의 상세한 문서
- 복사해서 바로 쓸 수 있는 코드 예시 포함
- AI가 참고할 수 있는 기술적 근거 명시

### 2. [PLAN.md](http://plan.md/) (실행 계획서)

**역할**: 사수가 시키는 오늘의 작업 리스트
**질문**: "어떻게(How) 구현할 것인가?"
**독자**: 실제로 코드를 작성하는 개발자 (AI 에이전트)

**포함 내용**:

- 8-10개의 마일스톤
- 각 마일스톤별 서브 태스크
- 순차적 의존성 관계
- 세션별 작업 노트
- 진행상황 체크리스트

**특징**:

- 한 마일스톤 = 한 개발 세션 (1-3시간)
- 지속적으로 업데이트되는 살아있는 문서
- 체크박스로 진행상황 시각화

### 3. [Claude.md](http://claude.md/) (시스템 프롬프트)

**역할**: AI 에이전트의 행동 지침서
**질문**: "어떤 규칙을 따라야 하는가?"
**독자**: Claude Code, Codex 같은 AI 에이전트

**포함 내용**:

- 필수 워크플로우
- 코드 품질 기준
- 금지 사항
- 테스트 전략

---

## 문서 구조

### 📁 프로젝트 루트 구조

**디렉토리 구조:**

```
your-project/
├── doc/
│   ├── TECHSPEC.md          # 기술 명세서 (읽기 전용)
│   └── PLAN.md              # 실행 계획 (지속 업데이트)
├── CLAUDE.md                # Claude Code용 시스템 프롬프트
├── src/                     # 소스 코드
└── README.md

```

---

## [TECHSPEC.md](http://techspec.md/) 작성 가이드

### 기본 구조

**문서 템플릿:**

# TechSpec: [프로젝트명]

## 1. Overview

한 문단으로 프로젝트 요약

## 2. Goals (목표)

- [ ] 구체적인 목표 1
- [ ] 구체적인 목표 2
- [ ] 측정 가능한 목표 3

## 3. Non-Goals (비목표)

- 이번에 하지 않을 것들 명시
- 범위 제한 (v2에서 할 것들)

## 4. Current State

- 현재 어떤 상태인가
- 왜 이 작업이 필요한가

## 5. Architecture

**시스템 구조:**

```
[다이어그램 또는 설명]
Component A → Component B → Result

```

## 6. Requirements

### 6.1 Functional Requirements

**REQ-1: [기능명]**

- 설명
- 입력/출력 예시
- 성능 기준

**REQ-2: [기능명]**
...

### 6.2 Non-Functional Requirements

**REQ-N: Performance**

- 메모리 사용량: < X MB
- 응답 시간: < Y ms

## 7. Implementation Details

### 7.1 REQ-1 구현 세부사항

**핵심 알고리즘:**

**Python 예시:**

```
def key_function():
    # TODO: 이 부분을 구현
    pass

```

**주의사항**:

- 구체적인 주의점
- 참고 자료

## 8. Testing Strategy

- 어떻게 테스트할 것인가

## 9. Success Criteria

- [ ] 완료 기준 1
- [ ] 완료 기준 2

---

### 작성 시 주의사항

**DO**:

- ✅ 코드 예시를 최대한 많이 포함
- ✅ "이렇게 해야 한다"보다 "이런 결과를 달성해야 한다"
- ✅ 숫자로 측정 가능한 기준 제시
- ✅ 본인도 이해할 수 있는 수준으로 작성

**DON'T**:

- ❌ 추상적인 설명만 나열
- ❌ 구현 방법을 너무 제한
- ❌ 이해하지 못한 채로 작성

---

## [PLAN.md](http://plan.md/) 작성 가이드

### 기본 구조

**문서 템플릿:**

# Implementation Plan: [프로젝트명]

## Context

- TechSpec: docs/TECHSPEC.md
- Timeline: X days
- Current Status: [Phase]

---

## Milestones Overview

**진행 상황:**

```
Progress: [=====>              ] 25%

M0: ████████████████████ 100% ✅
M1: ██████░░░░░░░░░░░░░░  30% 🔄
M2: ░░░░░░░░░░░░░░░░░░░░   0% ⬜
M3: ░░░░░░░░░░░░░░░░░░░░   0% ⬜

```

---

## Detailed Milestones

### ✅ Milestone 0: [이름]

**Status**: Completed
**Duration**: 30 minutes
**Commit**: abc1234

**Sub-tasks**:

- [x] 0.1 - 완료된 작업
- [x] 0.2 - 완료된 작업

**Notes**:

- 특이사항 기록

---

### 🔄 Milestone 1: [이름]

**Status**: In Progress (현재 작업 중)
**Estimated Duration**: 2 hours
**Requirements**: REQ-1, REQ-2 from TECHSPEC

**Sub-tasks**:

- [ ] 1.1 - 첫 번째 작업
- [ ] 1.2 - 두 번째 작업
- [ ] 1.3 - 세 번째 작업

### Sub-task 1.1: [구체적인 작업명]

**테스트 먼저 작성** (TDD):

**TypeScript 함수 테스트:**

```typescript
import { feature } from "./feature";

describe("feature", () => {
  it("예상한 값을 반환해야 함", () => {
    // 이 테스트가 통과하도록 구현
    const result = feature(input);
    expect(result).toBe(expected);
  });
});
```

**구현 가이드:**

**TypeScript 함수 구현:**

```typescript
export const feature = (input: unknown) => {
  // TODO: 여기를 구현
  return null;
};
```

**완료 기준**:

- [ ] 테스트 통과
- [ ] 코드 리뷰 완료
- [ ] 문서 업데이트

---

### ⬜ Milestone 2: [이름]

**Status**: Not Started
**Dependencies**: M1 완료 필요

---

## Development Workflow

### 매 세션 시작 시

1. ✅ docs/TECHSPEC.md 읽기 (필수)
2. ✅ PLAN.md에서 다음 작업 확인
3. ✅ 테스트 먼저 작성 (TDD)
4. ✅ 최소한의 코드로 구현
5. ✅ 테스트 통과 확인
6. ✅ [PLAN.md](http://plan.md/) 업데이트
7. ✅ 커밋

### 매 세션 종료 시

- [ ] 모든 테스트 통과
- [ ] [PLAN.md](http://plan.md/) 체크박스 업데이트
- [ ] 다음 세션을 위한 노트 작성
- [ ] Git 커밋 완료

---

## Session Notes

### Session 1 (2025-01-20)

**Milestone**: M1.1, M1.2
**Duration**: 1.5시간

**완료**:

- ✅ 기능 A 구현
- ✅ 테스트 작성

**이슈**:

- ⚠️ 메모리 사용량이 예상보다 높음
- 해결: 배치 크기를 64→32로 조정

**다음 세션 TODO**:

- [ ] M1.3 시작
- [ ] 성능 벤치마크 추가

**Commit**: feat(M1.1-M1.2): implement feature A

---

### Session 2 (Pending)

**Target**: M1.3 완료
**Estimated**: 1시간

---

### 마일스톤 크기 기준

**적절한 크기** (한 세션에 완료 가능):

- ⏱️ 1-3시간 작업량
- 📝 10-15개 파일 수정
- 📊 100-300줄 코드 추가
- ✅ 독립적으로 테스트 가능

**너무 큰 경우 쪼개기**:

- ❌ "사용자 인증 시스템 구현"
- ✅ "JWT 토큰 생성 로직 구현"
- ✅ "토큰 검증 미들웨어 구현"
- ✅ "리프레시 토큰 핸들러 구현"

---

## 워크플로우

### 🔄 전체 개발 사이클

**단계:**

```
1. TECHSPEC 작성 (2일)
   └─> 여러 AI 모델과 협의
   └─> 본인도 충분히 이해

2. PLAN 작성 (3시간)
   └─> TECHSPEC 기반
   └─> 8-10개 마일스톤

3. 마일스톤 구현 (반복)
   └─> 하나씩 순차 진행
   └─> 각 1-3시간

4. 통합 테스트

5. 배포

```

### 🎯 단일 마일스톤 사이클

**프로세스:**

```
1. TECHSPEC 읽기 (5분)
   - 관련 REQ 확인

2. PLAN 확인 (2분)
   - 다음 서브태스크 파악
   - 의존성 확인

3. 테스트 작성 (20분)
   - TDD 원칙 준수
   - Red 상태 확인

4. 구현 (60분)
   - 최소한의 코드
   - Green 상태 달성

5. 리팩토링 (10분)
   - 코드 개선
   - Green 유지

6. PLAN 업데이트 (3분)
   - 체크박스 표시
   - 노트 작성

7. 커밋 (2분)
   - 의미있는 메시지
   - PLAN.md 포함

```

---

## AI 에이전트 지침

> 이 섹션은 Claude Code, Codex 등 AI 에이전트가 읽고 따라야 합니다.

### 🤖 당신의 역할

당신은 이 프로젝트의 **시니어 엔지니어**입니다.

- TECHSPEC은 당신의 **북극성**입니다
- PLAN은 당신의 **오늘 할 일**입니다
- 테스트는 당신의 **성공 기준**입니다

### 📖 필수 읽기 자료

**매 세션 시작 시 반드시 읽기**:

1. docs/TECHSPEC.md - 전체 맥락 이해
2. PLAN.md - 현재 진행 상황과 다음 작업

**선택적 읽기**:

- 관련 코드 파일
- 이전 세션 노트
- 테스트 파일

### ✅ 반드시 해야 할 것 (DO)

**1. TECHSPEC 먼저 읽기**

대화 예시:

- 나: "이 기능 구현해줘"
- 당신: "[TECHSPEC 읽는 중...] 확인했습니다. REQ-3 관련이네요."

**2. 테스트 먼저 작성** (TDD)

올바른 순서:

```
# 1. 테스트 작성
def test_feature():
    assert feature() == expected

# 2. 구현
def feature():
    pass

```

**3. 작은 단위로 변경**

- 한 번에 100줄 이내
- 하나의 목적만
- 쉽게 리뷰 가능

**4. [PLAN.md](http://plan.md/) 업데이트**

업데이트 예시:

```
- [x] 1.1 - 완료됨 ✓

**Session Notes**:
- 이슈 발견: 메모리 누수
- 해결: 캐시 클리어 로직 추가
- Commit: abc1234

```

**5. 질문하기**

예시:
"TECHSPEC에 REQ-5의 성능 기준이 명확하지 않습니다. 100ms가 맞나요, 아니면 1초인가요?"

### ❌ 절대 하지 말아야 할 것 (DON'T)

**1. TECHSPEC 안 읽기**

- ❌ "바로 구현하겠습니다!"
- ✅ "[TECHSPEC 읽는 중...] REQ-2를 참고하여 구현하겠습니다."

**2. 테스트 건너뛰기**

- ❌ 구현 → (테스트 없음) → 커밋
- ✅ 테스트 → 구현 → 리팩토링 → 커밋

**3. 대량 변경**

- ❌ 500줄 변경, 20개 파일 수정
- ✅ 100줄 변경, 3-5개 파일 수정

**4. 완료된 마일스톤 수정**

- ❌ "M1이 완료되었지만 다시 고치겠습니다"
- ✅ "M1 수정이 필요합니다. 진행해도 될까요?"

**5. TODO 주석 남기기**

- ❌ # TODO: 나중에 구현
- ✅ 구현 완료 또는 이슈 생성

### 🎯 코드 품질 기준

**모든 코드는:**

**TypeScript 코드 예시:**

```typescript
// 명시적인 타입 정의 필수
type FeatureInput = {
  param: string;
  optional?: number;
};

type FeatureResult = string[];

// 파라미터와 반환 타입 명시
export const feature = (input: FeatureInput): FeatureResult => {
  if (!input.param) {
    throw new Error("param은 비어있을 수 없습니다");
  }

  // 변수 타입 명시
  const result: string[] = [];
  const processed: string = input.param.trim();

  return result;
};
```

**테스트 코드는:**

**TypeScript 테스트 예시:**

```typescript
import { feature } from "./feature";

describe("feature", () => {
  it("정상 케이스: 기대하는 입력", () => {
    const input = { param: "valid input" };
    const result = feature(input);
    expect(result).toEqual(["expected", "output"]);
  });

  it("엣지 케이스: 빈 입력", () => {
    const input = { param: "" };
    const result = feature(input);
    expect(result).toEqual([]);
  });

  it("에러 케이스: 잘못된 입력", () => {
    expect(() => {
      feature({ param: "" });
    }).toThrow("param은 비어있을 수 없습니다");
  });
});
```

### 📊 세션 완료 체크리스트

매 세션 종료 전:

- [ ] 모든 테스트 통과 (yarn test)
- [ ] 코드 스타일 일관성 확인
- [ ] 타입 작성 및 활용 확인 (typescript)
- [ ] [PLAN.md](http://plan.md/) 업데이트
- [ ] 세션 노트 작성
- [ ] 미완성 TODO 없음

### 💬 커뮤니케이션 스타일

**명확하게 보고**:

✅ 좋은 예:
"Milestone 1.3 완료했습니다.

- 테스트 5개 추가 (모두 통과)
- src/encoder.py 수정 (87줄 추가)
- [PLAN.md](http://plan.md/) 업데이트 완료
- Commit: feat(M1.3): add input validation (abc1234)

다음은 M1.4 (unit tests 완성)입니다. 진행할까요?"

❌ 나쁜 예:
"끝났어요. 다음 뭐 할까요?"

**막혔을 때**:

✅ 좋은 예:
"M2.2 구현 중 막혔습니다.

- 이슈: FAISS 설치가 M1 Mac에서 실패
- 시도: pip install faiss-cpu (실패)
- TECHSPEC 확인: REQ-3에 FAISS 필수
- 질문: conda로 설치하거나 다른 라이브러리 사용 가능한가요?"

❌ 나쁜 예:
"에러 나요. 어떻게 하죠?"

---

## 체크리스트

### 📝 프로젝트 시작 시

- [ ] docs/ 디렉토리 생성
- [ ] docs/TECHSPEC.md 작성 (2일 투자)
- [ ] [PLAN.md](http://plan.md/) 작성 (3시간 투자)
- [ ] [Claude.md](http://claude.md/) 작성
- [ ] Git 저장소 초기화
- [ ] 첫 커밋: "docs: add TECHSPEC and PLAN"

### 🔄 마일스톤 시작 시

- [ ] TECHSPEC에서 관련 REQ 확인
- [ ] PLAN에서 서브태스크 파악
- [ ] 의존성 확인 (이전 마일스톤 완료?)
- [ ] 브랜치 생성 (선택사항)

### ✅ 마일스톤 완료 시

- [ ] 모든 서브태스크 체크
- [ ] 테스트 커버리지 80% 이상
- [ ] [PLAN.md](http://plan.md/) 업데이트
- [ ] 세션 노트 작성
- [ ] Git 커밋
- [ ] (선택) PR 생성 및 리뷰

### 🎉 프로젝트 완료 시

- [ ] 모든 마일스톤 ✅
- [ ] Success Criteria 달성
- [ ] 문서 최종 업데이트
- [ ] README 작성
- [ ] 배포 또는 릴리스

---

## 부록: 예시

### 예시 1: 간단한 기능

**TECHSPEC 일부:**

**REQ-1: CSV 파일 파싱**

- 입력: CSV 파일 경로
- 출력: List[Dict] 형태의 데이터
- 제약: 10MB 이하 파일만 지원

**PLAN 일부:**

### Milestone 1: CSV Parser

- [ ] 1.1 - 파일 읽기 함수
- [ ] 1.2 - CSV 파싱 로직
- [ ] 1.3 - 에러 처리

**구현:**

**1. 테스트 먼저:**

```
def test_parse_csv():
    result = parse_csv("test.csv")
    assert len(result) == 3
    assert result[0]["name"] == "Alice"

```

**2. 구현:**

```
def parse_csv(filepath: str) -> List[Dict]:
    import csv
    with open(filepath) as f:
        return list(csv.DictReader(f))

```

### 예시 2: 복잡한 기능

**TECHSPEC 일부:**

**REQ-5: 분산 캐싱**

- Redis 기반 캐싱 레이어
- TTL: 1시간
- 캐시 미스 시 DB 조회

**PLAN 일부:**

### Milestone 3: Redis Integration

- [ ] 3.1 - Redis 연결 설정
- [ ] 3.2 - 캐시 get/set 래퍼
- [ ] 3.3 - TTL 관리
- [ ] 3.4 - 캐시 미스 핸들링
- [ ] 3.5 - 통합 테스트

---

## 참고 자료

- 원본 방법론: 사이오닉 AI 박진형 엔지니어
- TDD 참고: Kent Beck의 "Test-Driven Development"
- Git 커밋 메시지: Conventional Commits

---

## 버전 히스토리

- v1.0 (2025-01-20): 초안 작성
- v1.1 (예정): 실제 프로젝트 적용 후 개선

---

**이 문서는 프로젝트의 헌법입니다. 모든 기여자(AI 포함)는 이를 따라야 합니다.**
