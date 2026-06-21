# dotfiles

리눅스 환경 자동 세팅용 dotfiles + 설치 스크립트

## 🚀 지원 환경

- Debian / Ubuntu / Kali 계열
- zsh 기반 쉘 환경
- SSH 접속 환경 포함

## ⚡ 설치 방법

### 1. 레포 클론

```bash
git clone https://github.com/seoyul710/dotfiles.git
cd dotfiles/linux
```

### 2. 설치 스크립트 실행

```bash
chmod +x autosetup.sh
./autosetup.sh
```

## 🧠 설치되는 것들

### 기본 패키지

* gcc / g++ / make / gdb
* git / vim
* python3 / pip / venv
* curl / wget / file / xxd

### 쉘 환경

* zsh (기본 쉘 설정)
* starship prompt
* zsh autosuggestions
* zsh syntax highlighting

### 터미널 도구

* fastfetch (로그인 배너)
* kitty-terminfo (SSH 터미널 호환)

## 🎨 적용 내용

* .zshrc 자동 적용
* starship 설정 적용
* fastfetch 설정 적용
* 커스텀 프로필 적용 / 스위칭
* SSH 접속 시 fastfetch 자동 실행

## 🧑‍🎨 프로필 기능

프로필은 `profiles/<프로필명>` 경로에 저장됩니다.

각 프로필은 starship 프롬프트 설정과 fastfetch 배너 설정을 한 묶음으로 관리합니다.

```
profiles/
 └── chisa/
      ├── starship.toml
      └── fastfetch/
           ├── config.jsonc
           └── assets/
```

### 프로필 목록 확인

```bash
cd linux
./switch-profile.sh list
```

### 프로필 적용

```bash
cd linux
./switch-profile.sh apply chisa
```

적용 시 아래 파일이 갱신됩니다.

* `~/.config/starship.toml`
* `~/.config/fastfetch`
* `~/.config/dotfiles-profile`

기존 설정은 기본적으로 `.backup.YYYYMMDD-HHMMSS` 형식으로 백업됩니다.


### 프로필 커스터마이징

* `starship.toml` 수정으로 터미널 바 커스텀 가능
* `fastfetch/config.jsonc` 수정으로 시작 배너 커스텀 가능
  * 이미지 변경 시 1:1.6 비율의 투명 배경 이미지 사용

## ⚠️ 주의사항

* 설치 후 반드시 로그아웃/재로그인 필요
* zsh가 기본 쉘로 변경됨
* SSH 환경에서는 TERM 설정이 중요함 (kitty-terminfo 필요)

## 🔥 실행 예시 (원라이너)

```bash
git clone https://github.com/USER/dotfiles.git && cd dotfiles/linux && ./autosetup.sh
```

## 🧩 구조

```
dotfiles/
 ├── linux/
 │    ├── autosetup.sh
 │    ├── switch-profile.sh
 │    └── .zshrc
 └── profiles/
      └── chisa/
           ├── starship.toml
           └── fastfetch/
```

## 📌 목적

새 리눅스 서버/VM에서
한 번에 개발 환경을 복구하기 위한 자동화 세팅
