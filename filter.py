from pyspark.sql import SparkSession
from pyspark.sql.functions import col

# Start Spark session
spark = SparkSession.builder.appName("FilterFailedTransactions").getOrCreate()

# Load the input CSV file
df = spark.read.csv("gs://p1-project/input/Failed_transactions_IDBI.csv", header=True, inferSchema=True)

# Filter only FAILURE transactions
failed_df = df.filter(col("status") == "FAILURE")

# Optionally select important columns only
# failed_df = failed_df.select("transaction_id", "branch_id", "branch_name", "city", "transaction_date", "amount", "error_message")

# Save filtered results to GCS or local
failed_df.write.csv("gs://p1-project/output/Failed_transactions_only.csv", header=True, mode="overwrite")

spark.stop()
