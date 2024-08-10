kINESIS SPARK INTEGRATION



======================
🔴 1---Open cmd authenticate AWS
======================

aws configure

AccessKey - AKIAQE43KCX53CE75JFG
SecretKey - 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
region    - ap-south-1
format    - json


======================
🔴 2--- create a kinesis stream
======================

aws kinesis create-stream --stream-name zeyoaditya --shard-count 1

aws kinesis list-streams


==============
🔴 Push data Plan A
==============

aws kinesis put-record --stream-name <UNIQUE_STREAM_NAME> --partition-key 123 --cli-binary-format raw-in-base64-out --data firstmessage
aws kinesis put-record --stream-name <UNIQUE_STREAM_NAME> --partition-key 123 --cli-binary-format raw-in-base64-out --data secondmessage
aws kinesis put-record --stream-name <UNIQUE_STREAM_NAME> --partition-key 123 --cli-binary-format raw-in-base64-out --data thirdmessage

==============
🔴 Push data Plan B
==============




aws kinesis put-record --stream-name <UNIQUE_STREAM_NAME> --partition-key 123 --data firstmessage
aws kinesis put-record --stream-name <UNIQUE_STREAM_NAME> --partition-key 123 --data secondmessage
aws kinesis put-record --stream-name <UNIQUE_STREAM_NAME> --partition-key 123 --data thirdmessage


========
🔴 Create a fresh project in Eclipse/Intellij
Add kinjars
Put the code from common group
Change streaming name and group name  in the code





package pack


package pack

import org.apache.spark._
import org.apache.spark.streaming._
import org.apache.spark.sql.functions._
import org.apache.spark.sql._

import org.apache.spark.storage._
import org.apache.spark.sql.functions._
import org.apache.spark.streaming._
import com.amazonaws.services.kinesis.clientlibrary.lib.worker.KinesisClientLibConfiguration
import com.fasterxml.jackson.dataformat.cbor.CBORFactory
import com.fasterxml.jackson.core.TSFBuilder
import org.apache.spark.streaming.kinesis.KinesisUtils
import org.apache.spark.streaming.kinesis.KinesisInputDStream
import com.amazonaws.services.kinesis.clientlibrary.lib.worker.InitialPositionInStream



object obj {

	def b2s(a: Array[Byte]): String = new String(a)


			def main(args:Array[String]):Unit={


					val conf=	new	SparkConf().setAppName("ES").setMaster("local[*]").set("spark.driver.allowMultipleContexts","true")
							.set("AWS_ACCESS_KEY","AKIAQE43KCX53CE75JFG")
							.set("AWS_SECRET_KEY","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")
							.set("CBOR_DISABLED","true")

							val sc = new SparkContext(conf)

							sc.setLogLevel("ERROR")

							val spark = SparkSession.builder.getOrCreate()

							import spark.implicits._

							val ssc = new StreamingContext(conf,Seconds(2))



							val kinesisStream111= KinesisUtils.createStream(
									ssc,   // streaming context
									"<UNIQUE_ID>",  // group id
									"<UNIQUE_STREAM_NAME>",    // equal to topic name (stream name)
									"https://kinesis.ap-south-1.amazonaws.com",  // kinesis host
									"ap-south-1",
									InitialPositionInStream.LATEST,   // consumption model
									Seconds(1),  // Consumption Duration
									StorageLevel.MEMORY_AND_DISK)



						val finalstream=kinesisStream111.map(x=>b2s(x))	
						
						finalstream.print()
		
						
						
						ssc.start()
						
						ssc.awaitTermination()








	}

}