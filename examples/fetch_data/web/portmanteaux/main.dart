// Copyright (c) 2012, the Dart project authors.
// Please see the AUTHORS file for details.
// All rights reserved. Use of this source code
// is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';

UListElement wordList = querySelector('#wordList');

void main() {
  querySelector('#getWords').onClick.listen(makeRequest);
}

// #docregion makeRequest
Future<void> makeRequest(/*Event*/ dynamic _) async {
  // FIXME(https://github.com/dart-lang/sdk/issues/33627): type argument
  const path = 'https://www.dartlang.org/f/portmanteaux.json';
  try {
    // Make the GET request
    final jsonString = await HttpRequest.getString(path);
    // The request succeeded. Process the JSON.
    processResponse(jsonString);
  } catch (e) {
    // The GET request failed. Handle the error.
    // #enddocregion makeRequest
    print('Couldn\'t open $path');
    wordList.children.add(LIElement()..text = 'Request failed.');
    // #docregion makeRequest
  }
}

void processResponse(String jsonString) {
  for (final portmanteau in json.decode(jsonString)) {
    wordList.children.add(LIElement()..text = portmanteau);
  }
}