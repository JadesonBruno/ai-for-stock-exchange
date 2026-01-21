# 📈 AI for Stock Exchange

[![Python](https://img.shields.io/badge/Python-3.12.9-blue.svg)](https://www.python.org/)
[![Terraform](https://img.shields.io/badge/Terraform-1.13.0-purple.svg)](https://www.terraform.io/)
[![Docker](https://img.shields.io/badge/Docker-Enabled-blue.svg)](https://www.docker.com/)
[![AWS](https://img.shields.io/badge/AWS-EC2-orange.svg)](https://aws.amazon.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

> **Intelligent stock market analysis platform with AI agent and real-time analytics, automatically deployed to AWS EC2 using Infrastructure as Code (Terraform).**

## 📋 Table of Contents

- [Overview](#-overview)
- [Architecture](#-architecture)
- [Features](#-features)
- [Technology Stack](#-technology-stack)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Configuration](#-configuration)
- [Deployment](#-deployment)
- [AI Agent Module](#-ai-agent-module)
- [Analytics Module](#-analytics-module)
- [Troubleshooting](#-troubleshooting)
- [Acknowledgments](#-acknowledgments)
- [Support and Contact](#-support-and-contact)

---

## 🎯 Overview

**AI for Stock Exchange** is a data engineering and analytics project that combines artificial intelligence with stock market data analysis. The platform provides:

- **AI Agent**: Intelligent conversational agent powered by Groq's LLMs for stock market insights and recommendations
- **Real-time Analytics**: Interactive dashboards with technical indicators and market metrics
- **Automated Infrastructure**: Complete AWS deployment using Terraform and Docker
- **Scalable Architecture**: Containerized application ready for production environments

The entire infrastructure is provisioned as code, enabling reproducible deployments and easy scaling.

---

## 🏗️ Architecture

### Infrastructure Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         AWS Cloud (us-east-2)                   │
│                                                                 │
│  ┌────────────────────────────────────────────────────────────┐ │
│  │                       VPC Module                           │ │
│  │  ┌──────────────────────────────────────────────────────┐  │ │
│  │  │  Public Subnet (10.0.1.0/24)                         │  │ │
│  │  │                                                      │  │ │
│  │  │  ┌─────────────────────────────────────────────┐     │  │ │
│  │  │  │     EC2 Instance (t3.small)                 │     │  │ │
│  │  │  │     Ubuntu 22.04 LTS                        │     │  │ │
│  │  │  │                                             │     │  │ │
│  │  │  │  ┌────────────────────────────────────┐     │     │  │ │
│  │  │  │  │  Docker Engine                     │     │     │  │ │
│  │  │  │  │                                    │     │     │  │ │
│  │  │  │  │  ┌──────────────────────────────┐  │     │     │  │ │
│  │  │  │  │  │  Streamlit Application       │  │     │     │  │ │
│  │  │  │  │  │  - AI Agent (Groq API)       │  │     │     │  │ │
│  │  │  │  │  │  - Analytics Dashboard       │  │     │     │  │ │
│  │  │  │  │  │  - Technical Indicators      │  │     │     │  │ │
│  │  │  │  │  └──────────────────────────────┘  │     │     │  │ │
│  │  │  │  └────────────────────────────────────┘     │     │  │ │
│  │  │  └─────────────────────────────────────────────┘     │  │ │
│  │  │                                                      │  │ │
│  │  └──────────────────────────────────────────────────────┘  │ │
│  │                                                            │ │
│  │  Security Groups:                                          │ │
│  │  - SSH (22) - Restricted to your IP                        │ │
│  │  - HTTP (8501) - Streamlit app access                      │ │
│  └──────────────────────────────────────────────────────────────┘
│                                                                 │
│  Internet Gateway ←→ Route Tables                               │
└─────────────────────────────────────────────────────────────────┘
```

### Application Architecture

```
┌────────────────────────────────────────────────────────────┐
│                  Streamlit Web Application                 │
├────────────────────────────────────────────────────────────┤
│                                                            │
│  ┌────────────────────┐      ┌──────────────────────────┐  │
│  │   AI Agent Module  │      │   Analytics Module       │  │
│  │   (ai_agent.py)    │      │   (analytics.py)         │  │
│  │                    │      │                          │  │
│  │  - Groq LLM API    │      │  - Data Processing       │  │
│  │  - Context Memory  │      │  - Technical Indicators: │  │
│  │  - Conversational  │      │    • SMA (7, 30 days)    │  │
│  │    Interface       │      │    • RSI (14 periods)    │  │
│  │  - Stock Insights  │      │    • MACD                │  │
│  │                    │      │    • Bollinger Bands     │  │
│  │                    │      │  - Interactive Charts    │  │
│  │                    │      │  - Performance Metrics   │  │
│  └──────────┬─────────┘      └──────────┬───────────────┘  │
│             │                           │                  │
│             └───────────┬───────────────┘                  │
│                         │                                  │
│                    ┌────▼─────┐                            │
│                    │  app.py  │                            │
│                    │  (Main)  │                            │
│                    └──────────┘                            │
└────────────────────────────────────────────────────────────┘
```

### Deployment Flow

```
Developer Machine (Windows)
    │
    ├── docker-compose.terraform.yml
    │   └── Terraform Container (Ubuntu)
    │       └── terraform apply
    │           │
    │           ▼
    ┌───────────────────────────────┐
    │     Terraform Provisioning    │
    ├───────────────────────────────┤
    │ 1. Create VPC & Networking    │
    │ 2. Launch EC2 Instance        │
    │ 3. Configure Security Groups  │
    │ 4. Copy application files     │
    │ 5. Execute setup_web_app.sh   │
    │    - Install Docker           │
    │    - Pull dependencies        │
    │    - Run docker-compose       │
    └───────────────────────────────┘
                  │
                  ▼
        ┌──────────────────┐
        │   AWS EC2 Ready  │
        │   Application    │
        │   Running on     │
        │   Port 8501      │
        └──────────────────┘
```

---

## ✨ Features

### 🤖 AI Agent Capabilities
- **Conversational AI**: Natural language interface for stock market queries
- **Context-Aware**: Maintains conversation history for coherent interactions
- **Real-time Analysis**: Integration with Groq's advanced language models
- **Market Insights**: Intelligent recommendations based on technical and fundamental analysis

### 📊 Analytics Dashboard
- **Technical Indicators**:
  - **Simple Moving Averages (SMA)**: 7-day and 30-day trends
  - **Relative Strength Index (RSI)**: Overbought/oversold signals (14-period)
  - **MACD**: Moving Average Convergence Divergence for momentum analysis
  - **Bollinger Bands**: Volatility and price envelope indicators
- **Interactive Charts**: Real-time data visualization with Plotly
- **Performance Metrics**: Returns, volatility, and risk analysis
- **Historical Data**: Multi-timeframe analysis and backtesting

### 🚀 Infrastructure Features
- **Infrastructure as Code**: Entire stack defined in Terraform
- **Automated Deployment**: One-command deployment to AWS
- **Containerized**: Docker ensures consistent environments
- **Scalable**: Easy to replicate and scale across regions
- **Secure**: Security groups with IP whitelisting

---

## 🛠️ Technology Stack

| Category | Technologies |
|----------|--------------|
| **Languages** | Python 3.12.9, HCL (Terraform) |
| **AI/ML** | Groq API, LLaMA-based models |
| **Data Processing** | Pandas, NumPy |
| **Visualization** | Streamlit, Plotly |
| **Infrastructure** | Terraform 1.13.0, AWS (EC2, VPC) |
| **Containerization** | Docker, Docker Compose |
| **CI/CD** | Pre-commit hooks (Black, Flake8, Bandit) |
| **Dependency Management** | Poetry 2.0.1 |

---

## 📁 Project Structure

```
ai-for-stock-exchange/
├── app/
│   └── app.py                          # Streamlit main application
├── src/
│   ├── __init__.py
│   ├── ai_agent.py                     # AI agent module (Groq integration)
│   └── analytics.py                    # Analytics and indicators module
├── terraform/
│   ├── main.tf                         # Root Terraform configuration
│   ├── providers.tf                    # AWS provider configuration
│   ├── variables.tf                    # Variable definitions
│   ├── terraform.tfvars                # Variable values (user-configured)
│   └── modules/
│       ├── vpc/                        # VPC networking module
│       │   ├── main.tf
│       │   ├── outputs.tf
│       │   └── variables.tf
│       └── web_app/                    # EC2 application module
│           ├── main.tf                 # EC2 instance and provisioners
│           ├── outputs.tf
│           ├── security_group.tf       # Firewall rules
│           ├── ssh.tf                  # SSH key pair management
│           ├── variables.tf
│           └── scripts/
│               └── setup_web_app.sh    # Docker installation script
├── dockerfile                          # Application container definition
├── docker-compose.yml                  # Application orchestration
├── dockerfile.terraform                # Terraform container definition
├── docker-compose.terraform.yml        # Infrastructure orchestration
├── pyproject.toml                      # Python dependencies (Poetry)
├── poetry.lock                         # Locked dependency versions
├── .env                                # Environment variables (secrets)
├── .pre-commit-config.yaml             # Code quality hooks
└── README.md                           # This file
```

---

## 📋 Prerequisites

### Local Development Machine
- **Docker Desktop**: Latest version with WSL2 backend (Windows) or native Docker (Linux/Mac)
- **Git**: For version control
- **Text Editor**: VS Code recommended

### AWS Account
- **AWS Account** with permissions to create:
  - EC2 instances
  - VPC resources (subnets, route tables, internet gateway)
  - Security groups
  - Key pairs
- **AWS Credentials**: Access Key ID and Secret Access Key

### API Keys
- **Groq API Key**: Register at [Groq Console](https://console.groq.com/)

---

## ⚙️ Configuration

### 1. Configure Terraform Variables

Edit `terraform/terraform.tfvars`:

```hcl
# General Variables
project_name = "ai-for-stock-exchange"
environment  = "dev"
aws_region   = "us-east-2"
allow_ips    = ["YOUR_PUBLIC_IP/32"]  # Use: curl -s https://ifconfig.me

# Web App Variables
web_app_instance_type = "t3.small"
ami_id                = "ami-0f5fcdfbd140e4ab7"  # Ubuntu Server 22.04 LTS (us-east-2)
default_user          = "ubuntu"
```

**Important**:
- Replace `YOUR_PUBLIC_IP` with your actual public IP address
  - PowerShell: `(Invoke-RestMethod 'https://ipinfo.io/ip').Trim()`
  - Bash: `curl -s https://ifconfig.me`
- Verify the `ami_id` is correct for your chosen region (Ubuntu 22.04 LTS)

### 2. Configure Environment Variables

Create `.env` file in the project root:

```bash
# Groq API Key (required for AI agent)
GROQ_API_KEY="your-groq-api-key-here"

# AWS Credentials (for Terraform container)
AWS_ACCESS_KEY_ID="your-aws-access-key"
AWS_SECRET_ACCESS_KEY="your-aws-secret-key"
AWS_DEFAULT_REGION="us-east-2"
```

**Security Note**: Never commit `.env` to version control. It's already in `.gitignore`.

---

## 🚀 Deployment

### Step 1: Start Terraform Container

Navigate to the project root directory and start the Terraform environment:

```powershell
# Build and start the Terraform container
docker compose -f docker-compose.terraform.yml build --no-cache
docker compose -f docker-compose.terraform.yml up -d
```

### Step 2: Access Terraform Container

Enter the container shell:

```powershell
docker compose -f docker-compose.terraform.yml exec terraform bash
```

You'll be inside the container at `/workspaces/ai-for-stock-exchange-infra/terraform`.

### Step 3: Initialize Terraform

Initialize the Terraform working directory:

```bash
terraform init
```

This will:
- Download AWS provider plugins
- Configure S3 backend (if configured)
- Initialize modules

### Step 4: Review Infrastructure Plan

Preview what Terraform will create:

```bash
terraform plan
```

Review the output to ensure:
- VPC and networking resources
- EC2 instance with correct AMI
- Security groups with your IP
- SSH key pair creation

### Step 5: Deploy Infrastructure

Apply the Terraform configuration:

```bash
terraform apply
```

Type `yes` when prompted. This process will:
1. Create VPC with public subnet
2. Launch EC2 instance (t3.small, Ubuntu 22.04 LTS)
3. Configure security groups (SSH port 22, HTTP port 8501)
4. Generate and upload SSH key pair
5. Copy application files to EC2
6. Execute `setup_web_app.sh` to:
   - Install Docker and Docker Compose
   - Pull application container
   - Start the Streamlit app

**Deployment takes approximately 5-10 minutes.**

### Step 6: Access the Application

After successful deployment, Terraform will output the public IP:

```
Outputs:

web_app_public_ip = "3.133.110.209"
```

Access the application at:
```
http://<PUBLIC_IP>:8501
```

Example: `http://3.133.110.209:8501`

### Step 7: SSH Access (Optional)

To access the EC2 instance via SSH:

```bash
# From the Terraform container
terraform output -raw web_app_private_key > /tmp/key.pem
chmod 400 /tmp/key.pem
ssh -i /tmp/key.pem ubuntu@<PUBLIC_IP>
```

---

## 🤖 AI Agent Module

**File**: `src/ai_agent.py`

### Overview

The AI Agent module provides an intelligent conversational interface for stock market analysis using Groq's advanced language models (LLaMA-based).

### Key Features

1. **Context Management**
   - Maintains conversation history across sessions
   - Preserves user preferences and previous queries
   - Enables multi-turn dialogues with coherent responses

2. **LLM Integration**
   - **Model**: LLaMA 3.1 70B Versatile (via Groq API)
   - **Temperature**: 0.7 (balanced creativity and accuracy)
   - **Max Tokens**: 1024 (sufficient for detailed responses)

3. **Capabilities**
   - Stock market trend analysis
   - Investment recommendations
   - Risk assessment and portfolio advice
   - Technical analysis interpretation
   - Market news summarization

### Usage Example

```python
from src.ai_agent import AIAgent

# Initialize agent
agent = AIAgent(api_key=os.getenv("GROQ_API_KEY"))

# Query the agent
response = agent.query("What are the current trends in the tech sector?")
print(response)

# Follow-up question (uses context)
response = agent.query("Should I invest in this sector?")
```

### Architecture

```
User Query → Context Builder → Groq API → Response Parser → User
                ↑                                ↓
                └────────── History Store ──────┘
```

---

## 📊 Analytics Module

**File**: `src/analytics.py`

### Overview

The Analytics module provides comprehensive technical analysis and data visualization capabilities for stock market data.

### Technical Indicators

#### 1. Simple Moving Average (SMA)
**Purpose**: Identifies trend direction and support/resistance levels.

- **7-day SMA**: Short-term trend (captures weekly patterns)
- **30-day SMA**: Medium-term trend (monthly momentum)

**Formula**:
```
SMA(n) = (P₁ + P₂ + ... + Pₙ) / n
```

**Interpretation**:
- Price > SMA → Bullish signal
- Price < SMA → Bearish signal
- SMA crossovers → Trend reversals

#### 2. Relative Strength Index (RSI)
**Purpose**: Measures momentum and identifies overbought/oversold conditions.

- **Period**: 14 days (industry standard)
- **Range**: 0 to 100

**Formula**:
```
RSI = 100 - (100 / (1 + RS))
RS = Average Gain / Average Loss (over 14 periods)
```

**Interpretation**:
- RSI > 70 → Overbought (potential sell signal)
- RSI < 30 → Oversold (potential buy signal)
- RSI = 50 → Neutral momentum

#### 3. MACD (Moving Average Convergence Divergence)
**Purpose**: Identifies trend changes and momentum shifts.

**Components**:
- **MACD Line**: 12-day EMA - 26-day EMA
- **Signal Line**: 9-day EMA of MACD line
- **Histogram**: MACD line - Signal line

**Interpretation**:
- MACD crosses above Signal → Bullish
- MACD crosses below Signal → Bearish
- Histogram expansion → Strengthening trend
- Histogram contraction → Weakening trend

#### 4. Bollinger Bands
**Purpose**: Measures volatility and identifies price extremes.

**Components**:
- **Middle Band**: 20-day SMA
- **Upper Band**: Middle + (2 × Standard Deviation)
- **Lower Band**: Middle - (2 × Standard Deviation)

**Interpretation**:
- Price touches upper band → Overbought
- Price touches lower band → Oversold
- Band squeeze → Low volatility (breakout incoming)
- Band expansion → High volatility

### Performance Metrics

#### Returns Calculation
```python
daily_return = (current_price - previous_price) / previous_price
cumulative_return = (final_price - initial_price) / initial_price
```

#### Volatility (Standard Deviation)
```python
volatility = std(daily_returns) * sqrt(252)  # Annualized
```

#### Sharpe Ratio (Risk-Adjusted Return)
```python
sharpe_ratio = (mean_return - risk_free_rate) / std_return
```

### Visualization Features

- **Interactive Charts**: Plotly-based with zoom, pan, hover
- **Multi-timeframe Analysis**: Daily, weekly, monthly views
- **Overlay Indicators**: SMA, Bollinger Bands on price chart
- **Separate Panels**: RSI and MACD in dedicated subplots
- **Volume Analysis**: Trading volume bars

---

## 🐛 Troubleshooting

### Common Issues

#### 1. Bind Mount Errors on Windows

**Error**:
```
Error response from daemon: error while creating mount source path
'/run/desktop/mnt/host/c/...': mkdir /run/desktop/mnt/host/c: file exists
```

**Cause**: Docker Desktop on Windows with WSL2 has known issues with bind mounts, especially when mounting multiple individual files/folders.

**Solution**: This project avoids bind mounts by using `COPY` in Dockerfiles instead of volumes. If you modified `docker-compose.terraform.yml` or `docker-compose.yml` and added volumes, remove them:

```yaml
# ❌ Don't do this (causes errors on Windows)
volumes:
  - ./terraform:/workspaces/terraform

# ✅ Use COPY in Dockerfile instead
# (already implemented in this project)
```

If you still encounter issues:
```powershell
# Clean up Docker state
docker compose -f docker-compose.terraform.yml down -v --remove-orphans
docker system prune -a --volumes

# Restart WSL2
wsl --shutdown

# Restart Docker Desktop
```

#### 2. Line Ending Issues (CRLF vs LF)

**Error** (on EC2 during provisioning):
```
bash: ./setup_web_app.sh: /bin/bash^M: bad interpreter
```

**Cause**: Windows uses CRLF (`\r\n`) line endings, but Linux requires LF (`\n`). If `setup_web_app.sh` has CRLF endings, it will fail on the EC2 instance.

**Solution**: Ensure `setup_web_app.sh` uses **LF line endings**:

**In VS Code**:
1. Open `terraform/modules/web_app/scripts/setup_web_app.sh`
2. Check bottom-right corner → should show "LF"
3. If it shows "CRLF", click and select "LF"
4. Save the file

**Via Git**:
```bash
# Configure Git to checkout LF (recommended)
git config core.autocrlf input

# Convert existing file
dos2unix terraform/modules/web_app/scripts/setup_web_app.sh
```

**Prevention**: Add to `.gitattributes`:
```
*.sh text eol=lf
```

#### 3. Terraform Provider Crash

**Error**:
```
Error: Plugin did not respond
fatal error: fault
[signal SIGBUS: bus error code=0x2 addr=0xb22a60 pc=0xb22a60]
```

**Solutions**:

1. **Clear Terraform cache**:
```bash
rm -rf .terraform .terraform.lock.hcl
terraform init
```

2. **Use stable AWS provider version** (edit `terraform/providers.tf`):
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # Use 5.x instead of 6.x
    }
  }
}
```

3. **Increase container memory** (if running in resource-constrained environment).

#### 4. Permission Denied (SSH Key)

**Error**:
```
Permission denied (publickey)
```

**Solution**:
```bash
# Ensure correct permissions on private key
chmod 400 /tmp/key.pem
ssh -i /tmp/key.pem ubuntu@<PUBLIC_IP>
```

#### 5. Application Not Accessible

**Checklist**:
- [ ] Verify security group allows port 8501 from your IP
- [ ] Check EC2 instance is running: `docker ps` on the instance
- [ ] Check Docker logs: `docker logs ai-for-stock-exchange`
- [ ] Verify `.env` file was copied correctly to EC2
- [ ] Ensure GROQ_API_KEY is set in `.env`

---

## 🙏 Acknowledgments

- [Groq](https://groq.com/) - Ultra-fast LLM inference platform
- [Terraform](https://www.terraform.io/) - Infrastructure as Code tool
- [AWS](https://aws.amazon.com/) - Cloud infrastructure provider
- [Docker](https://www.docker.com/) - Containerization platform
- [Streamlit](https://streamlit.io/) - Interactive web application framework
- [Plotly](https://plotly.com/) - Interactive visualization library
- [Poetry](https://python-poetry.org/) - Python dependency management

---

## 📞 Support and Contact

**Jadeson Bruno**
- 📧 Email: jadesonbruno.a@outlook.com
- 🐙 GitHub: [@JadesonBruno](https://github.com/JadesonBruno)
- 💼 LinkedIn: [Jadeson Bruno](https://www.linkedin.com/in/jadeson-silva/)

---

⭐ **If this project was helpful, please give it a star on GitHub!**

📝 **License**: MIT - see the [LICENSE](LICENSE) file for details.

**Made with ❤️ by [Jadeson Bruno](https://github.com/JadesonBruno)**
