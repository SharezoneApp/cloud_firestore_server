import 'package:cloud_firestore_server/cloud_firestore_server.dart';

final fakeCredentials = ServiceAccountCredentials.fromJsonMap({
  "type": "service_account",
  "project_id": "non-existing-project",
  "private_key_id": "24d8b410ff66b168dw23df71a6250bf76f6e4f2d",
  "private_key":
      "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhawddadawdwgwggSkAgEAAoIBAQDpQMe2mPbV+nP5\nEiC5yxFnjHe2Y7vH1eHRJaotdAwx5ScHffNHx2nnFI9hAy2OoudqrTXvy7Ln+wUs\nENwzdl2cU4CWTzT2j0WWaEqsVVgKHf8wyEZVWnVjJyZ0loQ81OdacuTVblWcbxZW\n5cbUGQ+YUdQiYtcvdqK+9u/VQQeBF1femtV5wbgTZyvv56hpL3aPz8RvWlvs8ef4\nuXcjB9XhZDHIdkSinyeWuQMhV4j2/SVSqfSmMRryTv+CDj7UzFpyII/JuGypofhF\nCubRiREc48nsJB8cD3dNz1C6qvSpfXJMZPO9H/pxxzd1T8KFeCeb1Lc2GtpMm6rf\n2ebmNplPAgMBAAECggEAdBp0Lo5OU21yu7hLxN9xHt9bGVTkfBCY8j+yySQ6C736\nIu8NIR4AN29S/SGVVCn/Uei878svluwqg2gzC4SwDOe9mlP703y2UStBfC2RAJw0\n0aXm6IZ55uxuZlsjoJoDPNDy2dAtWgwrjP6b7Sg6TIHyu1kCrpP5Z1/IOpi/cP/n\nkl1uka5UaTroRJBabPJc2CI8ednwzSjx8wUcLRqnDYLAGHNPfavTX6Ebum1Mfput\nSutRrg8OI4catYAhRo3NucPbvRQdFJ3Gysp0PzGIa8Aufz1/TXazF4shxSt2JEnp\n0IHzh9YsbyXdHTmuOsxDNb29Oh4ZRIf3p3W2z4RrLQKBgQD/WczFAz2mnIX1plAj\nIrR44PDXqPcTH01HXz5xBEi4U1SqaOWiECYeMK1AwwPYw0tEEfbTOrAiLZ1zo5Tl\nV7FW2prVYTEWXQiykdj+f3iNwbWTg7jSCq5hcHMjHm8Hae9Qw2bi+f4ZSQzzBR/o\nyWEuKehrCwUfbbMd9krmi2zaRQKBgQDp2Jj10MqX/703F5IHAl10S6IvCQy/dD3P\ntHbJ4V82ekJCOQS0iRGj+Avlz9KIiXu5d/krYibMKnqOdTo2rOSMsk423RkMwPa9\n3JbKteEx+HcGP3RtbX6CbiFsvOHUgbzEtOfLMe9JtsA4uptv9hJaI5W9KbJ9hG2F\nu3yIrVnIgwKBgQCVkw+Mk+JoFyWtCDfG7QxUBkdtvE7GR76nwRW9c+n49u8QRxPE\nA7ugUZka52D4dyU+gVtYzfbgfmHNnBOa5+w8WR77QMxVMjfnCeHW6eo+9yoad70q\nZBFTiGAZQTl+WUJSx7Mb355FR3IrZGQVouim9utq0HC2wTZ7pYqoUyF3FQKBgGL7\nB2OlCNvlp9WV6H2HBr+e8/ssvXScYz1ziYRSHNcWUM1vDQrNqeXZrE+N8/NPHkuW\n+KTgWsO4hz+dZxKVg/f50Rlv5JZ9ZvNeV4VeDv/zx42hdkqLOi1DKGq6WGx2rcwl\nNqfPbxWogRyCACEX6xS0U0FKUP7H+wPMJB5GIea5AoGBAKtAeprrEIsUMFmRFnXs\nftBXI9cH8PvQ53K2NrAPBbEmBgNb1PB1m6CvT1fFJczaGn3U4kBcuZuNeKDCp0dl\ncGQ3euroJcE29xFy03oAFFASeEj3hQjT+74xmwDMcTWCb+gLSyRGUyhuGETiVgz8\nRRMlwktjkFh+uuE+kazNkXpx\n-----END PRIVATE KEY-----\n",
  "client_email":
      "firebase-adminsdk-jw92a@non-existing-project.iam.gserviceaccount.com",
  "client_id": "110773944545549142870",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url":
      "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-jw92a%40non-existing-project.iam.gserviceaccount.com"
});
