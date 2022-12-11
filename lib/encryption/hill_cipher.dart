// import 'package:hill_cipher/hill_cipher.dart' as hill_cipher;
import 'dart:io';

class HillCipher {
  // static java_util_Scanner userInput = new java_util_Scanner(System.in_);
  // String? userInput = stdin.readLineSync();

  static void encrypt(String message) {
    message = message.toUpperCase();
    print("Enter key matrix size");
    int? matrixSize = int.parse(stdin.readLineSync()!); //userInput.nextInt();
    print("Enter Key/encryptionKey matrix ");
    // List<List<int>> keyMatrix = new List<int>(matrixSize)[matrixSize];
    var keyMatrix = List.generate(
        matrixSize, (i) => List.filled(matrixSize, 0, growable: false),
        growable: false);

    for (int i = 0; i < matrixSize; i++) {
      for (int j = 0; j < matrixSize; j++) {
        keyMatrix[i][j] =
            int.parse(stdin.readLineSync()!); //userInput.nextInt();
      }
    }
    validateDeterminant(keyMatrix, matrixSize);
    // List<List<int>> messageVector = new List<int>(matrixSize)[1];
    List<List<int>> messageVector = List.generate(
        matrixSize, (i) => List.filled(1, 0, growable: false),
        growable: false);

    // ignore: non_constant_identifier_names
    String CipherText = "";
    // List<List<int>> cipherMatrix = new List<int>(matrixSize)[1];

    // var cipherMatrix = <int>[matrixSize][1];
    List<List<int>> cipherMatrix = List.generate(
        matrixSize, (i) => List.filled(1, 0, growable: false),
        growable: false);

    // List.generate(matrixSize, 1, growable: false);
    int j = 0;
    while (j < message.length) {
      for (int i = 0; i < matrixSize; i++) {
        if (j >= message.length) {
          messageVector[i][0] = 23;
        } else {
          messageVector[i][0] = (message.codeUnitAt(j) % 65);
        }
        print(messageVector[i][0]);
        j++;
      }
      int x;
      int i;
      for ((i = 0); i < matrixSize; i++) {
        cipherMatrix[i][0] = 0;
        for ((x = 0); x < matrixSize; x++) {
          cipherMatrix[i][0] += (keyMatrix[i][x] * messageVector[x][0]);
        }
        print(cipherMatrix[i][0]);
        cipherMatrix[i][0] = (cipherMatrix[i][0] % 26);
      }
      for ((i = 0); i < matrixSize; i++) {
        CipherText += (String.fromCharCode(cipherMatrix[i][0] + 65));
        // print("CipherText:$CipherText");
      }
    }
    print("Ciphertext:$CipherText");
  }

  static void decrypt(String message) {
    message = message.toUpperCase();
    print("Enter key matrix size");
    int n = int.parse(stdin.readLineSync()!); //userInput.nextInt();
    print("Enter inverseKey/decryptionKey matrix ");
    // List<List<int>> keyMatrix = new List<int>(n)[n];
    var keyMatrix = List.generate(n, (i) => List.filled(n, 0, growable: false),
        growable: false);
    for (int i = 0; i < n; i++) {
      for (int j = 0; j < n; j++) {
        keyMatrix[i][j] =
            int.parse(stdin.readLineSync()!); //userInput.nextInt();
      }
    }
    validateDeterminant(keyMatrix, n);
    // List<List<int>> messageVector = new List<int>(n)[1];
    var messageVector = List.generate(n, (i) => <int>[1], growable: false);
    // ignore: non_constant_identifier_names
    String PlainText = "";
    // List<List<int>> plainMatrix = new List<int>(n)[1];
    var plainMatrix = List.generate(
        n, (i) => List.filled(1, 0, growable: false),
        growable: false);

    int j = 0;
    while (j < message.length) {
      for (int i = 0; i < n; i++) {
        if (j >= message.length) {
          messageVector[i][0] = 23;
        } else {
          messageVector[i][0] = (message.codeUnitAt(j) % 65);
        }
        print(messageVector[i][0]);
        j++;
      }
      int x;
      int i;
      for ((i = 0); i < n; i++) {
        plainMatrix[i][0] = 0;
        for ((x = 0); x < n; x++) {
          plainMatrix[i][0] += (keyMatrix[i][x] * messageVector[x][0]);
        }
        plainMatrix[i][0] = (plainMatrix[i][0] % 26);
      }
      for ((i = 0); i < n; i++) {
        PlainText += (String.fromCharCode(plainMatrix[i][0] + 65));
      }
    }
    print("Plaintext:$PlainText");
  }

  static int determinant(List<List<int>> a, int n) {
    int det = 0;
    int sign = 1;
    int p = 0;
    int q = 0;
    if (n == 1) {
      det = a[0][0];
    } else {
      // List<List<int>> b = new List<int>((n - 1))[n - 1];
      var b = List.generate(n - 1, (i) => <int>[n - 1], growable: false);
      for (int x = 0; x < n; x++) {
        p = 0;
        q = 0;
        for (int i = 1; i < n; i++) {
          for (int j = 0; j < n; j++) {
            if (j != x) {
              b[p][q++] = a[i][j];
              if ((q % (n - 1)) == 0) {
                p++;
                q = 0;
              }
            }
          }
        }
        det = (det + ((a[0][x] * determinant(b, n - 1)) * sign));
        sign = (-sign);
      }
    }
    return det;
  }

  static void hillCipher(String message) {
    message.toUpperCase();
    print("What do you want to process from the message?");
    print("Press 1: To Encrypt");
    print("Press 2: To Decrypt");
    int? sc = int.parse(stdin.readLineSync()!); //userInput.nextShort();
    if (sc == 1) {
      encrypt(message);
    } else {
      if (sc == 2) {
        decrypt(message);
      } else {
        print("Invalid input, program terminated.");
      }
    }
  }

  static void validateDeterminant(List<List<int>> keyMatrix, int n) {
    if ((determinant(keyMatrix, n) % 26) == 0) {
      print("Invalid key, as determinant = 0. Program Terminated");
      return;
    }
  }
}

void main(List<String> args) {
  print(String.fromCharCode(65));
  print("Enter message");
  String message = stdin.readLineSync()!; //userInput.nextLine();
  HillCipher.hillCipher(message);
}