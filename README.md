# Duty Wallet

<div align="center">
    <img src="img/icon.png" alt="AppIcon" height="150">
</div>

![](https://img.shields.io/badge/iOS-16%2B-green?logo=apple)
![](https://img.shields.io/badge/Swift%205.9-FA7343?style=flat&logo=swift&logoColor=white)

This app stores your debts and loans, with extensible repository pattern on Realm

<div style="display: flex; flex-direction: row; flex-wrap: wrap; justify-content: center; column-gap: 24px; row-gap: 20px;">
  <span><img src="img/1.png" style="width:200px;"></span>
</div>

## Структура проекта

```
DutyWallet
├── System
│   └── DutyWalletApp
│
├── Repository
│   ├── Entity
│   │   └── ...
│   ├── RepositoryProtocol
│   └── RealmRepository
│
├── UI
│   ├── Component
│   │   └── ...
│   └── Screen
│       ├── View
│       │   └── ...
│       └── ViewModel
│           └── ...
│
├── Model
│
└── ...   <- Extensions, Utilities and Resourses
```

## Технологии и инструменты

- [SwiftUI](https://developer.apple.com/xcode/swiftui/)
- [Realm](https://realm.io/realm-swift/)
- [Repository Pattern](https://habr.com/ru/articles/248505/)
