# Specialized Consulting Module in the field of data using AI Agents.
# Practical consulting project in the field of data using AI Agents.
# App Deployment for Day Trade Analytics in real time using Ai Agents,
# Groq, Deepseek and AWS for monetization.

# import third-party libraries
import pandas as pd
import yfinance as yf


def extract_data(ticker: str, period: str = "6mo") -> pd.DataFrame:
    """Define the function to extract historical stock data based on the given ticker
    and period.

    Parameters:
        ticker (str): The stock ticker symbol.
        period (str): The period for which to fetch historical data. Default is '6mo'.
    """

    # Fetch historical stock data
    stock = yf.Ticker(ticker)

    # Get historical data for the specified period
    hist = stock.history(period=period)
    # Reset index to convert the Date index into a column
    hist.reset_index(inplace=True)

    return hist
