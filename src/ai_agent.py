# Specialized Consulting Module in the field of data using AI Agents.
# Practical consulting project in the field of data using AI Agents.
# App Deployment for Day Trade Analytics in real time using Ai Agents,
# Groq, Deepseek and AWS for monetization.

# AI Agent Module

# Import third-party libraries
from agno.agent import Agent
from agno.models.groq import Groq
from agno.team import Team
from agno.tools.duckduckgo import DuckDuckGoTools
from agno.tools.yfinance import YFinanceTools
from dotenv import load_dotenv

# Load environment variables from .env file
load_dotenv()


# Define Web Search Agent
web_search_agent = Agent(
    name="Web Search Agent",
    role="Perform web searches to gather relevant information.",
    model=Groq(id="openai/gpt-oss-120b"),
    tools=[DuckDuckGoTools()],
    instructions=["Always include news sources.", "Answer in Portuguese-BR."],
    markdown=True,
)


# Define Finance Agent
finance_agent = Agent(
    name="Finance Agent",
    model=Groq(id="openai/gpt-oss-120b"),
    tools=[
        YFinanceTools(
            include_tools=[
                "get_current_stock_price",
                "get_analyst_recommendations",
                "get_stock_fundamentals",
                "get_company_news",
            ]
        )
    ],
    instructions=["Use tables to display data.", "Answer in Portuguese-BR."],
    markdown=True,
)


# Define Multi AI Agent Team
multi_ai_agent = Team(
    name="Multi AI Agent Team",
    members=[web_search_agent, finance_agent],
    model=Groq(id="openai/gpt-oss-120b"),
    instructions=[
        "Always include news sources.",
        "Use tables to display data.",
        "Answer in Portuguese-BR.",
    ],
    markdown=True,
)
