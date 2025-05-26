# 💡 Wattio – Desafio Flutter: Marketplace de Energia
Descrição: [desafio_frontend_wattio.pdf](./desafio_frontend_wattio.pdf)

Este projeto implementa um marketplace de energia onde usuários podem informar o valor médio da conta de luz mensal e receber ofertas de cooperativas de energia que oferecem descontos de acordo com sua faixa de consumo.

---

## 🚀 Tecnologias utilizadas

- [Flutter](https://flutter.dev/)
- [Riverpod](https://riverpod.dev/) – Gerenciamento de estado
- [Dart](https://dart.dev/) – Linguagem de programação
- `flutter_test` e `mocktail` – Testes unitários e de widget

---

## 📦 Estrutura de Pastas

```
lib/
├── core/
│   └── models/
├── features/
│   └── energy_marketplace/
│       ├── application/        // Providers
│       ├── domain/             // Use cases (opcional)
│       └── presentation/       // Tela e widgets
test/
├── models/                     // Testes de lógica
└── widgets/                    // Testes de UI
```

---

## 🛠️ Como rodar o projeto

### 1. Instale as dependências

```bash
flutter pub get
```

### 2. Execute o app

```bash
flutter run
```

### 3. Execute os testes

```bash
flutter test
```

---

## ✅ Funcionalidades

- Entrada do valor médio da conta de energia
- Listagem de cooperativas compatíveis com base na faixa de consumo
- Cálculo e exibição da economia estimada com base no desconto da cooperativa
- Validação de entrada inválida
- Feedback visual (loading) durante carregamento de ofertas
- Testes unitários e de widget cobrindo principais funcionalidades

---

## 🙏 Agradecimento

Agradeço à equipe da **Wattio** pela oportunidade de participar deste processo seletivo.  
Foi um prazer desenvolver esse desafio, que envolveu lógica de negócio, boas práticas de UI, gerenciamento de estado e testes automatizados.


Atenciosamente,  
**[Eduardo Silva Borges, Desenvolvedor Flutter Pleno]**
