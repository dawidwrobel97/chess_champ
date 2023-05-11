<div align="center">

# Chess Champ

Chess Champ is a flutter app meant to help chess players improve on their, mistakes.

<p float = "left">
    <img src="lib/src/assets/images/app1.jpg" height=577.2 width=260 > 
    <img src="lib/src/assets/images/app2.jpg" height=577.2 width=260 >
    <img src="lib/src/assets/images/app3.jpg" height=577.2 width=260 >
</p>
</div>

## Bulit with

<img src="lib/src/assets/images/flutter.png" height=40 width=53.3 > Dart/Flutter - main language and framework.

### Most important used dependencies
- [flutter_bloc](https://pub.dev/packages/flutter_bloc) v8.1.2 - A library used for state management
- [cloud_firestore](https://pub.dev/packages/cloud_firestore) v4.4.5 - Cloud hosted database
- [firebase_auth](https://pub.dev/packages/firebase_auth) v4.2.2 - A library used for authentication
- [json_serializable](https://pub.dev/packages/json_serializable) v6.6.1 - A library for automatically generating code for converting to and from JSON
- [dio](https://pub.dev/packages/dio) v5.0.0 -  HTTP client for managing Lichess API
- [retrofit](https://pub.dev/packages/retrofit) v4.0.1 - A dio client generator
- [get_it](https://pub.dev/packages/get_it) v7.2.0 -  Service locator that allows to decouple the interface from a concrete implementation
- [injectable](https://pub.dev/packages/injectable) v2.1.1 - get_it generator
- [freezed](https://pub.dev/packages/freezed) v2.3.2 - Code generation for immutable classes
- [bloc_test](https://pub.dev/packages/bloc_test) v9.1.1 - A testing library for bloc

## Overview

Chess Champ is meant to be used as a training app when learning chess. It allows the user to enter their, lichess account and the app downloads their, last 10 games. It then calculates the biggest mistake the user made in each of these games and gives the user a chance to try and find the best move instead. Alternatively if you can't find the best move you can press a button to give out the solution.

## How does it work?
- First, user logs in  with an existing account or creates a new one.

https://github.com/dawidwrobel97/chess_app/assets/117597306/5501aeb2-4052-4056-b468-b6a1b4b6b745

- Then you can enter your lichess account username(or some other person you might want to check)


https://github.com/dawidwrobel97/chess_app/assets/117597306/180ee916-9282-4999-b734-9412a3f95785

- From here you can check any of the games in the list. Once opened, the app will show you what was the wrong move you played with a red arrow, along with some stats and a solution button underneath. Now the user can attempt to find what move was best. If you can't find it, you can press the solution button for an answer.


https://github.com/dawidwrobel97/chess_app/assets/117597306/c6920099-d4f7-495f-bfdd-5c8d3f5ff1d8

At any moment you can delete the current lichess account and use a different one


https://github.com/dawidwrobel97/chess_app/assets/117597306/a1301c2a-ad7e-442e-9de6-0644756df136



