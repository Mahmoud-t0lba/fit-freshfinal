import 'package:fit/Screens/150or250.dart';
import 'package:fit/Screens/Cartscreen150.dart';
import 'package:fit/Screens/aboutus.dart';
import 'package:fit/Screens/adminscreens/addofferspages.dart';
import 'package:fit/Screens/adminscreens/addproduct.dart';
import 'package:fit/Screens/adminscreens/adminhome.dart';
import 'package:fit/Screens/adminscreens/editdetails.dart';
import 'package:fit/Screens/adminscreens/editproduct.dart';
import 'package:fit/Screens/adminscreens/orderdetails.dart';
import 'package:fit/Screens/adminscreens/topscreen.dart';
import 'package:fit/Screens/adminscreens/vieworders.dart';
import 'package:fit/Screens/cart_screen.dart';
import 'package:fit/Screens/cartscreen.dart';
import 'package:fit/Screens/category_screen.dart';
import 'package:fit/Screens/favouritesscreen.dart';
import 'package:fit/Screens/forgetpasswordscreen/forgetpsswordscreen.dart';
import 'package:fit/Screens/homepagescreen/homepagescreen.dart';
import 'package:fit/Screens/navigaterHandA.dart';
import 'package:fit/Screens/offers.dart';
import 'package:fit/Screens/offersdetails.dart';
import 'package:fit/Screens/onpoareding.dart';
import 'package:fit/Screens/productinfo.dart';
import 'package:fit/Screens/signinscreen/signin.dart';
import 'package:fit/Screens/updatepassword.dart';
import 'package:fit/Screens/updatephone.dart';
import 'package:fit/Screens/userdatascree.dart';
import 'package:fit/model/product.dart';
import 'package:fit/model/user_modal.dart';
import 'package:fit/providers/Model.dart';
import 'package:fit/providers/cartitem.dart';
import 'package:fit/Screens/signupscreen/signupscreen.dart';
import 'package:fit/providers/favorite.dart';
import 'package:fit/providers/theme.dart';
import 'package:fit/services/auth.dart';
import 'package:fit/widgets/update_email.dart';
import 'package:fit/widgets/update_name.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/spalchscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/theme.dart';

/// variable store initScreen.
int initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  /// this is way how to see one time onBoard
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);

  /// using shared preferences to store current user.

  /// initializing firebase in main method.

  runApp(FITApp());
}

class FITApp extends StatefulWidget {
  @override
  _FITAppState createState() => _FITAppState();
}

class _FITAppState extends State<FITApp> {
  String userId;

  /// this method get current user.
  void getUserId() async {
    final _auth = Auth();
    String user = await _auth.currentUser();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userId = preferences.getString('userId');
      userId = user;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModalHud>(create: (context) => ModalHud()),
        ChangeNotifierProvider<Cartitem>(create: (context) => Cartitem()),
        ChangeNotifierProvider<ThemeCustom>(create: (context) => ThemeCustom()),
        ChangeNotifierProvider<Product>(create: (context) => Product()),
        ChangeNotifierProvider<UserModal>(create: (context) => UserModal()),
        ChangeNotifierProvider<Favorite>(create: (context) => Favorite()),
      ],
      child: MaterialApp(
        home: SplashScreen(
          screen: initScreen == 0 || initScreen == null
              ? OnPoardingScreen()
              : userId == null
                  ? SignInScreen()
                  : HomePageScreen(),
        ),
        routes: {
          SplashScreen.id: (context) => SplashScreen(),
          OnPoardingScreen.id: (context) => OnPoardingScreen(),
          SignInScreen.id: (context) => SignInScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          HomePageScreen.id: (context) => HomePageScreen(),
          ForgetPasswordScreen.id: (context) => ForgetPasswordScreen(),
          NavigaterPage.id: (context) => NavigaterPage(),
          AdminPageHome.id: (context) => AdminPageHome(),
          AddProduct.id: (context) => AddProduct(),
          EditProductPage.id: (context) => EditProductPage(),
          VeiwOrdersPage.id: (context) => VeiwOrdersPage(),
          ProductInfo.id: (context) => ProductInfo(),
          EditDetails.id: (context) => EditDetails(),
          CartScreen.id: (context) => CartScreen(),
          OrderDetails.id: (context) => OrderDetails(),
          Favourtie.id: (context) => Favourtie(),
          Offers.id: (context) => Offers(),
          AboutUs.id: (context) => AboutUs(),
          Category.id: (context) => Category(),
          CartScreenCat.id: (context) => CartScreenCat(),
          TopHomeScreen.id: (context) => TopHomeScreen(),
          UserDataScreen.id: (context) => UserDataScreen(),
          AddOffers.id: (context) => AddOffers(),
          OffersINfo.id: (context) => OffersINfo(),
          // UserDataScreen.id:(context)=>UserDataScreen()
          MeduimLarge.id: (context) => MeduimLarge(),
          UPdatePassword.id: (context) => UPdatePassword(),
          UpdatePhone.id: (context) => UpdatePhone(),
          UpdateName.id: (context) => UpdateName(),
          UpdateEmail.id: (context) => UpdateEmail(),
          Cart150.id: (context) => Cart150()
        },
      ),
    );
  }
}
