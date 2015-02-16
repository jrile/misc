name := """hello-akka"""

version := "1.0"

scalaVersion := "2.11.1"

libraryDependencies ++= Seq(
  "com.typesafe.akka" %% "akka-actor" % "2.3.4",
  "com.typesafe.akka" %% "akka-testkit" % "2.3.4",
  "org.scalatest" %% "scalatest" % "2.1.6" % "test",
  "junit" % "junit" % "4.11" % "test",
  "com.novocode" % "junit-interface" % "0.10" % "test",
  "com.netflix.rxjava" % "rxjava-scala" % "0.15.0",
 "org.json4s" % "json4s-native_2.10" % "3.2.5",
 "org.scala-lang" % "scala-swing" % "2.10.3",
 "net.databinder.dispatch" % "dispatch-core_2.10" % "0.11.0",
 "org.scala-lang" % "scala-reflect" % "2.10.3",
 "org.slf4j" % "slf4j-api" % "1.7.5",
 "org.slf4j" % "slf4j-simple" % "1.7.5",
 "com.squareup.retrofit" % "retrofit" % "1.0.0",
 "org.scala-lang.modules" %% "scala-async" % "0.9.0-M2",
 "org.scalacheck" %% "scalacheck" % "1.10.1"
)

testOptions += Tests.Argument(TestFrameworks.JUnit, "-v")
