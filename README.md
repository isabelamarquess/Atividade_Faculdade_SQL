# 🏥 Sistema de Gerenciamento de Clínica Médica: Cuidar Bem

Este projeto implementa a estrutura de um banco de dados relacional para gerenciar as principais operações de uma clínica médica fictícia chamada **Cuidar Bem**. A estrutura foi definida com base em um Diagrama de Entidade-Relacionamento (DER) e é implementada usando comandos SQL.

---

## 🚀 Estrutura do Projeto

O banco de dados gerencia informações essenciais como cadastro de pacientes, médicos, recepcionistas, agendamento de consultas e prontuários médicos.

### 💾 Modelo de Dados (DER)

O modelo relacional é composto pelas seguintes entidades e seus relacionamentos:

* **`Paciente`**: Cadastro de pessoas atendidas na clínica.
* **`Recepcionista`**: Funcionários responsáveis pelo cadastro e agendamento.
* **`Medico`**: Profissionais de saúde responsáveis pelas consultas e prontuários.
* **`Consulta`**: Registro de um atendimento agendado.
* **`Prontuario`**: Documento médico que detalha o diagnóstico e a prescrição de uma consulta.

| Tabela | Chave Primária | Chaves Estrangeiras (FK) |
| :--- | :--- | :--- |
| **`Paciente`** | CPF | Nenhuma |
| **`Medico`** | CRM | Nenhuma |
| **`Recepcionista`** | CPF | Nenhuma |
| **`Consulta`** | `id_consulta` | `CPF_paciente`, `CRM_medico`, `id_prontuario` |
| **`Prontuario`** | `id_prontuario` | `CRM_medico_responsavel`, `id_consulta` |
