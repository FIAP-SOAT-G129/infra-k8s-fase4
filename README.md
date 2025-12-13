# ☸ Infraestrutura Kubernetes na AWS (EKS)

Este repositório contém a infraestrutura do cluster Kubernetes para o projeto Fastfood, provisionada via **Terraform** na AWS. Inclui:

- Amazon EKS (Elastic Kubernetes Service)
- Security Group dedicados ao EKS
- Backend remoto em S3

---

## 📦 Estrutura do Projeto

```text
infra-k8s-fase4/
│── main.tf                # Configuração principal e orquestração dos módulos
│── variables.tf           # Variáveis globais do projeto
│── terraform.tfvars       # Valores das variáveis (exceto secrets)
│── providers.tf           # Provider AWS
│── datasource.tf          # Data source para estados remotos
│── backend.tf             # Configuração do backend remoto S3
│── modules/               # Módulos reutilizáveis
│   ├── eks/               # Módulo de eks
│   ├── security-group/    # Módulo de Security Group
```

---

## ⚙️ Pré-requisitos

- [Terraform >= 1.5](https://developer.hashicorp.com/terraform/downloads)
- AWS CLI configurado
- VPC e subnets privadas já provisionadas [infra-foundation-fase4](https://github.com/FIAP-SOAT-G129/infra-foundation-fase4)
- Permissões suficientes para criar EKS e Load Balancer

---

## 🚀 Como usar

### 1. Inicializar o Terraform

```bash
terraform init
```

### 2. Validar a configuração

```bash
terraform validate
```

### 3. Planejar alterações

```bash
terraform plan -var-file="terraform.tfvars" -var-file="secrets.tfvars"
```

### 4. Aplicar alterações

```bash
terraform apply -var-file="terraform.tfvars" -var-file="secrets.tfvars"
```

---

## 🔑 Backend remoto

O estado do Terraform (`terraform.tfstate`) é armazenado no bucket S3:

- **Bucket:** `fastfood-tf-states`
- **Folder:** `infra/k8s/`

A configuração completa está no arquivo `backend.tf`.

---

## 🔒 Segurança

- Security Groups são configurados para permitir o tráfego adequado para o cluster.
- Roles específicas são atribuídas ao EKS e ao NLB via IAM.

## 🏗️ Pipeline de Automação

O projeto utiliza pipelines CI/CD no GitHub Actions para garantir a automação, qualidade e segurança do provisionamento da infraestrutura. Os principais workflows estão em `.github/workflows/`:

- **fmt-validate.yml**: Executa `terraform fmt` e `terraform validate` em todos os PRs e pushes, garantindo que o código esteja formatado e válido antes de ser aplicado.

- **plan.yml**: Gera o plano de execução do Terraform (`terraform plan`) para cada alteração, permitindo revisão prévia das mudanças que serão aplicadas na infraestrutura.

- **apply.yml**: Aplica as alterações aprovadas na infraestrutura (`terraform apply`) após revisão e aprovação do plano.

- **destroy.yml**: Automatiza a destruição dos recursos provisionados, geralmente utilizado para ambientes temporários ou de testes.
  
- **destroy-terraform.yml**: Realiza a destruição controlada dos recursos via Terraform, garantindo limpeza segura e rastreável do ambiente.

- **terraform.yml**: Workflow principal de integração contínua, podendo orquestrar validação, plano, aplicação e notificações.

### Benefícios da automação

- Reduz erros manuais e aumenta a rastreabilidade
- Garante validação e revisão antes de qualquer alteração
- Permite auditoria e histórico de mudanças
- Facilita rollback e destruição controlada de recursos

Consulte cada arquivo em `.github/workflows/` para detalhes e personalizações.