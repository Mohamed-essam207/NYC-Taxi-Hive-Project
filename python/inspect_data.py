import pandas as pd

# Load the taxi dataset
df = pd.read_parquet("data/yellow_tripdata_2025-01.parquet")

# Display basic information
print("Number of rows:", len(df))
print("Number of columns:", len(df.columns))

print("\nColumns:")
for column in df.columns:
    print("-", column)