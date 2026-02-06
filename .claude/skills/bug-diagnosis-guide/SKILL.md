---
name: bug-diagnosis-guide
description: Athler 프로젝트 버그 진단 가이드. 버그 원인 파악이나 디버깅 방법이 필요할 때 사용합니다.
allowed-tools: Read, Glob, Grep, Bash
model: haiku
---

# 버그 진단 가이드

## 핵심 원칙

**추측하지 마라. 코드 증거를 찾을 때까지 추적하라.**

- "아마 이것일 것 같다" 금지
- "이 파일 N번 라인에서 X 때문에 발생한다" 수준의 정확한 원인을 찾을 것
- 원인을 날카롭게 설명할 수 없으면 아직 충분히 추적하지 않은 것이다

## 진단 워크플로우

### 1단계: 증상 파악 및 재현

- 에러 메시지, 기대 동작 vs 실제 동작 정리
- 영향 범위 파악 (특정 플랫폼? 특정 화면? 특정 데이터?)
- **재현 시도 → 최소 재현 단계로 축소**
  - 재현 최소화가 검색 범위를 자연스럽게 좁혀줌
  - 재현 없이는 수정 검증이 불가능함

### 2단계: 범위 좁히기 및 원인 추적

상황에 맞는 기법을 적용:

**역추적(Backtracing)** — 스택 트레이스가 있을 때
- 에러 발생 지점에서 호출 체인을 역방향으로 추적

**이진 탐색(Binary search)** — 언제 발생했는지 모를 때
- git bisect로 버그 유입 커밋 찾기
- 코드를 반으로 나누어 "이 영역에 버그가 있는가?" 반복

```bash
git bisect start
git bisect bad HEAD
git bisect good [정상 동작했던 커밋]
```

**데이터 흐름 추적** — 잘못된 값이 표시될 때
- 입력 → 가공 → 출력 경로를 따라감
- props → state → render, API 응답 → 가공 → 표시

**가설-검증 루프**
- 가설 수립 → 증거 수집 → 검증 → 기각 시 다음 가설 → 반복
- 증거가 나올 때까지 반복

### 3단계: 원인 확정

- 정확한 파일 경로와 라인 번호를 명시
- 왜 이 코드가 버그를 발생시키는지 논리적으로 설명
- 언제 유입되었는지 (가능하면 커밋 해시 포함)

### 4단계: 수정 및 검증

```bash
yarn test --findRelatedTests [수정된 파일]
yarn eslint --fix --cache [수정된 파일]
```

## 로컬 디버깅 도구

- **console.log**: 로컬 디버깅에서 자유롭게 사용 (커밋 코드에서만 Logger 사용 규칙 적용)
- **Metro 콘솔**: `yarn metro` — React Native 로그 확인
- **브라우저 DevTools**: `yarn web:start` — 웹 디버깅
- **Android 로그**: `yarn android:log`
- **iOS 로그**: Xcode Console 또는 `yarn react-native log-ios`

## 수정 후 필수 절차

1. 디버깅용 console.log 제거
2. `yarn test --findRelatedTests [파일]`
3. `yarn eslint --fix --cache [파일]`
4. (선택) `/troubleshooting-docs`로 해결 과정 기록
