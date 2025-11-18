# 📱 HealthShift  
### Monitoramento diário de humor, fadiga e hidratação para profissionais da saúde  
**Feito pelos alunos:**  
**Igor Marcos, João Gomes e Giovana Zakaluk**  
Disciplina: Programação para Dispositivos Móveis — 2025/2  
Professor: Raphael Lopes de Souza

---

## 📌 Sobre o projeto

O **HealthShift** é um aplicativo mobile desenvolvido em **Flutter** com o objetivo de auxiliar **profissionais da saúde** a monitorarem seu nível de fadiga, humor e hidratação ao longo dos turnos de trabalho.

Profissionais de saúde enfrentam jornadas longas, estresse elevado e risco de burnout. O app atua como um assistente simples e rápido, permitindo:

- Registrar um *check-in* diário (humor, fadiga e peso);
- Visualizar um **dashboard** com recomendações personalizadas de hidratação;
- Acompanhar o **histórico semanal** e padrões de bem-estar.

O projeto atende aos requisitos da disciplina, incluindo:
✔ Flutter como tecnologia obrigatória  
✔ Protótipo com pelo menos 3 telas  
✔ Interação com APIs (simuladas internamente)  
✔ Aplicação com foco em utilidade e impacto no cotidiano  

---

## 👨‍⚕️ Público-alvo

Este aplicativo foi fundamentado em uma pesquisa de campo com profissionais da área da saúde (mín. 15 participantes), incluindo:

- Enfermeiros  
- Médicos residentes  
- Técnicos de enfermagem  
- Fisioterapeutas  
- Dentistas  

A pesquisa buscou entender fatores como:
- Fadiga durante o expediente  
- Hidratação percebida  
- Cansaço emocional  
- Qualidade do humor ao longo dos turnos  
- Necessidade de ferramentas de gestão pessoal  

---

## 📋 Funcionalidades

### ✔ 1. Check-in Diário
Permite o registro de:
- Humor (1–5)  
- Fadiga (1–5)  
- Peso (para cálculo de hidratação)

### ✔ 2. Dashboard
Mostra:
- Humor do dia  
- Fadiga do dia  
- Recomendação personalizada de hidratação  
- Mensagem motivacional  

### ✔ 3. Histórico
Lista todos os check-ins anteriores, exibindo:
- Data e horário  
- Humor + Emoji  
- Fadiga + Descrição  
- Peso (quando informado)  

---

## 🧪 APIs utilizadas (simuladas)

O projeto simula interações com API usando uma camada chamada `ApiService`, com:

- `POST /checkin`
- `GET /checkin/today`
- `GET /checkin/history`
- `GET /hydration/recommendation`

As respostas são armazenadas em memória durante a execução do app.

---

## 🏗 Arquitetura da Aplicação

```text
lib/
 ├── main.dart
 ├── models/
 │     └── checkin.dart
 ├── services/
 │     └── api_service.dart
 └── screens/
       ├── checkin_screen.dart
       ├── dashboard_screen.dart
       └── history_screen.dart
```

### 📁 Screens
- `checkin_screen.dart` → Tela de Check-in  
- `dashboard_screen.dart` → Tela de Dashboard  
- `history_screen.dart` → Tela de Históricos  

### 🧠 Models
- `checkin.dart` → Estrutura de dados do check-in

### 🌐 Services
- `api_service.dart` → Simula requisições de API com `Future` + `delay`

---

## ▶️ Como rodar o projeto

1. Instale Flutter na sua máquina:  
   https://docs.flutter.dev/get-started/install

2. Crie um projeto novo:
   ```bash
   flutter create healthshift
   ```

3. Substitua **toda a pasta `/lib`** pelos arquivos deste projeto.

4. No `pubspec.yaml`, adicione (caso ainda não tenha):

   ```yaml
   dependencies:
     flutter:
       sdk: flutter
     intl: ^0.19.0
   ```

5. Rode:
   ```bash
   flutter pub get
   flutter run
   ```

---

## 🧪 Protótipo (Baixa Fidelidade)

O protótipo inclui:

1. Tela de Check-in  
2. Tela de Dashboard  
3. Tela de Histórico  

Fluxo principal:

```text
Check-in → Dashboard → Histórico → (volta via BottomNavigationBar)
```

---

## 📊 Pesquisa de Campo

A pesquisa realizada com profissionais da saúde continha 15+ respostas e abordou:

- Jornada de trabalho  
- Fadiga percebida  
- Sinais de burnout  
- Lembrança de hidratação  
- Hábitos de autocuidado  
- Interesse em um aplicativo de bem-estar  

*Os dados tabulados encontram-se em planilhas eletrônicas (não incluídas neste repositório por questões de privacidade).*

---

## 🛠 Tecnologias

- **Flutter 3.x**
- **Dart**
- **Intl** (formatação de datas)
- **Material Design 3**
- API simulada via classes internas

---

## 📚 Licença

Este projeto foi desenvolvido exclusivamente para fins acadêmicos na disciplina **Programação para Dispositivos Móveis (PDM)** — USCS.

---

## 👩‍💻 Integrantes

- **Igor Marcos**  
- **João Gomes**  
- **Giovana Zakaluk**

---

## 🎯 Objetivo Geral do Projeto

Criar uma aplicação mobile utilizando Flutter que seja **útil**, **funcional** e contribua para o **planejamento e bem-estar diário** de profissionais da saúde, alinhada aos requisitos do projeto semestral e às orientações do professor.

---

## 💬 Contato

Para dúvidas ou melhorias, procure os autores do projeto.
