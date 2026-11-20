<div align="center">

<img src="./logo.png" alt="ABA Alimentos e Distribuição" width="120">

# ABA Gestão
### Controle Financeiro

Sistema de gestão financeira e operacional da **ABA Alimentos e Distribuição** — cestas básicas e compras sob demanda em Gama, Brasília/DF.

![Status](https://img.shields.io/badge/status-MVP-2d6a4f?style=flat-square)
![Stack](https://img.shields.io/badge/stack-HTML%20%7C%20CSS%20%7C%20JS-d3a84c?style=flat-square)
![Licença](https://img.shields.io/badge/uso-interno-6c7a70?style=flat-square)

</div>

---

## ✨ O que o sistema faz

| Módulo | Funcionalidade |
|---|---|
| 📊 **Dashboard** | Receita, custos, lucro e margem em tempo real, com filtro por período |
| 👥 **Clientes** | Cadastro completo com histórico individual de pedidos e lucro gerado |
| 📦 **Pedidos / Serviços** | Cestas básicas e compras sob demanda, com cálculo automático de lucro |
| 💰 **Custos** | Compras, frete, gasolina, entrega e outras categorias personalizáveis |
| 🧾 **Comprovantes** | Suporte a compras sem nota, sem travar o cálculo do lucro |
| 💳 **Pagamentos** | Controle de recebimento, inclusive parcelado |
| 🧮 **Calculadora** | Simula o lucro de uma venda antes de fechar negócio |
| 📈 **Gráficos** | Receita × custos × lucro, custos por categoria, ranking de clientes |
| 📦 **Estoque** | Saldo por produto, estoque mínimo com alerta, entradas, saídas e ajuste por contagem |
| 🧺 **Cestas** | Composição de produtos, custo calculado pelo último preço pago, margem e preço sugerido |
| 🚚 **Fornecedores** | Cadastro, total comprado e histórico de compras por fornecedor |
| 📥 **A receber** | Saldo em aberto por cliente somando todos os pedidos, baixa de um pagamento em vários pedidos de uma vez e histórico de recebimentos |
| 🧾 **Recibo** | Recibo ou demonstrativo para o cliente com valores cobrados, pagamentos e saldo, sem custos; imprime, salva PDF ou copia como texto |
| 💾 **Backup** | Exportação e importação (.json), inclusive arquivos de lançamento que só acrescentam registros |

## 🛠️ Tecnologia

Aplicação em **HTML, CSS e JavaScript puro**, sem build. Os dados ficam no **Supabase** (login por e-mail e senha, uma linha por usuário com os dados em JSON, regras de acesso por usuário e cópias automáticas). O navegador guarda uma cópia local para funcionar sem internet; o que for salvo offline sobe quando a conexão volta.

A estrutura do banco está em [`supabase.sql`](supabase.sql). Todas as tabelas têm o prefixo `aba_` e só os usuários listados em `aba_usuarios` acessam o sistema.

## 🚀 Como usar

Abra o link do GitHub Pages, entre com o seu login e, no primeiro acesso, importe o backup (.json) da versão anterior. Os mesmos dados abrem no computador e no celular.

## 🗺️ Roadmap

- [x] Dashboard, clientes, pedidos, compras, custos, pagamentos, comprovantes, calculadora
- [x] Controle de estoque
- [x] Cadastro de fornecedores
- [x] Cestas com composição de produtos e custo automático
- [x] Importação de backup e de lançamentos
- [x] A receber, recibo para o cliente
- [x] Versão online com login e dados na nuvem
- [ ] Relatórios avançados e exportação
- [ ] Lucro líquido (com despesas administrativas)

---

<div align="center">
<sub>Projeto de uso interno · ABA Alimentos e Distribuição</sub>
</div>