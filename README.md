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
| 📅 **Ciclos mensais** | Clientes com valor fechado por mês: junta as compras do mês (parte 1, parte 2...), divide o pagamento entre elas e compara custo e lucro com o mês anterior |
| 💰 **Custos** | Compras, frete, gasolina, entrega e outras categorias personalizáveis |
| 🧾 **Comprovantes** | Suporte a compras sem nota, sem travar o cálculo do lucro |
| 💳 **Pagamentos** | Controle de recebimento, inclusive parcelado |
| 🧮 **Calculadora** | Simula o lucro de uma venda antes de fechar negócio |
| 📈 **Gráficos** | Receita × custos × lucro, custos por categoria, ranking de clientes |

## 🛠️ Tecnologia

Aplicação em **HTML, CSS e JavaScript puro** — sem build tools, sem dependências de instalação. Os dados ficam salvos localmente no navegador (`localStorage`), sem backend nem banco de dados externo.

## 🚀 Como usar

Abra o arquivo `index.html` diretamente no navegador. Não precisa de servidor nem internet (exceto para carregar fontes e gráficos via CDN).

> ⚠️ **Importante:** os dados são salvos por navegador/dispositivo — abrir o mesmo arquivo em outro computador não traz os dados já cadastrados. Use **Configurações → Exportar backup (.json)** com frequência para não perder informações.

## 🗺️ Roadmap

- [x] Dashboard, clientes, pedidos, compras, custos, pagamentos, comprovantes, calculadora
- [x] Controle de estoque
- [x] Cadastro de fornecedores
- [x] Cestas com composição de produtos e custo automático
- [x] Ciclos mensais para clientes com valor fechado
- [ ] Relatórios avançados e exportação
- [ ] Lucro líquido (com despesas administrativas)

---

<div align="center">
<sub>Projeto de uso interno · ABA Alimentos e Distribuição</sub>
</div>