# dotfiles

리눅스 환경 자동 세팅용 dotfiles + 설치 스크립트

---

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
* SSH 접속 시 fastfetch 자동 실행

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
 └── linux/
      ├── autosetup.sh
      ├── .zshrc
      ├── starship.toml
      └── fastfetch/
```

## 📌 목적

새 리눅스 서버/VM에서
한 번에 개발 환경을 복구하기 위한 자동화 세팅
