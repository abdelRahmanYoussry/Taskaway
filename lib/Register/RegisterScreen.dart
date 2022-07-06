import 'package:algorizainternship/Componets/Componets.dart';
import 'package:algorizainternship/Componets/ElevatedButton.dart';
import 'package:algorizainternship/Componets/TextFormField.dart';
import 'package:algorizainternship/Login/LoginScreen.dart';
import 'package:algorizainternship/Style/Colors.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
    var emailController= TextEditingController();
    var passwordController= TextEditingController();
    var formKey=GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        toolbarHeight: mediaQuery.height/10,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/image/background.jpg'),
                  fit: BoxFit.fitWidth
              )
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                Text('Welcome to Fashion Daily ',
                  style: Theme.of(context).textTheme.caption!.copyWith(fontSize:14 ),),
                const SizedBox(height: 20,),
                Text('Register ',
                  style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.black),),
                const SizedBox(height: 20,),
                Text('Email ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
                MyTextFormField(
                  textInputFormat:"[a-zA-Z0-9-@.]",
                  backgroundColor: Colors.white,
                  borderColor: const Color(0xffebedee),
                  control:emailController ,
                  isPassword: false,
                  hint: 'Eg: Example@gmail.com ',
                  validator: (value)
                  {
                    if(value.isEmpty)
                      return 'Email Can not be Empty';
                    else
                      return null;
                  },
                  readOnly: false,
                  labelColor: Colors.black,
                  type: TextInputType.emailAddress,
                  onTap: (){},
                  textColor: Colors.black,
                  onChanged: (value){},
                ),
                const SizedBox(height: 10,),
                Text('Phone Number ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
                MyTextFormField(
                  textInputFormat: '[0-9]',
                  backgroundColor: Colors.white,
                  borderColor: const Color(0xffebedee),
                  control:emailController ,
                  isPassword: false,
                  hint: 'Eg 035338114',
                  validator: (value)
                  {
                    if(value.isEmpty)
                      return 'Phone Can not be Empty';
                    else
                      return null;
                  },
                  readOnly: false,
                  prefix: CountryPickerDropdown(
                    initialValue: 'EG',
                    itemBuilder: _buildDropdownItem,
                    // itemFilter:  ['AR', 'DE', 'GB', 'CN'].contains(c.isoCode),
                    priorityList:[
                      CountryPickerUtils.getCountryByIsoCode('GB'),
                      CountryPickerUtils.getCountryByIsoCode('CN'),
                    ],
                    sortComparator: (Country a, Country b) => a.isoCode.compareTo(b.isoCode),
                    onValuePicked: (Country country) {
                      print(country.name);
                    },
                  ),
                  labelColor: Colors.black,
                  type: TextInputType.emailAddress,
                  onTap: (){},
                  textColor: Colors.black,
                  onChanged: (value){},
                ),
                const SizedBox(height: 10,),
                Text('Password ',
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
                MyTextFormField(
                  textInputFormat:"[a-zA-Z0-9]",
                  backgroundColor: Colors.white,
                  borderColor: const Color(0xffebedee),
                  control:passwordController ,
                  isPassword: true,
                  suffix: Icons.remove_red_eye,
                  hint: 'Password',

                  validator: (value)
                  {
                    if(value.isEmpty)
                      return 'Password Can not be Empty';
                    else
                      return null;
                  },
                  readOnly: false,
                  labelColor: Colors.black,
                  type: TextInputType.emailAddress,
                  onTap: (){},
                  textColor: Colors.black,
                  onChanged: (value){},
                ),
                const SizedBox(
                  height: 20,
                ),
                MyElevatedButton(
                  borderColor:Colors.blue ,borderWidth: 0,
                  height: 50, width: double.infinity,
                  onTap: (){
                    if(formKey.currentState!.validate()){
                      print('All is ok');
                    }
                  }, buttonName: 'Register',
                  buttonColor: Colors.blue,radius: 5,),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,height: 0.5,
                        decoration: const BoxDecoration(
                          color: Colors.grey,

                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text('Or',style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),),
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,height: 0.5,
                        decoration: const BoxDecoration(
                          color: Colors.grey,

                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                MyElevatedButton(
                  borderWidth: 2,
                  borderColor: Colors.blue,
                  height: 50, width:double.infinity,
                  textColor: Colors.blue,
                  onTap: (){}, buttonName: 'Sign With Google',
                  image:  const AssetImage(
                    'assets/image/googleLogo.png',
                  ),
                  buttonColor: Colors.white,radius: 5,),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('have an account',style: TextStyle(
                        color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16
                    ),),
                    TextButton(onPressed: (){
                      navigateTo(context, widget: const LoginScreen());
                    }, child: const Text(
                      'Sign in',style: TextStyle(
                        color: Colors.blue,fontSize: 16,fontWeight: FontWeight.bold
                    ),
                    ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text ('By regestring your account ,you are agree to our ',
                      style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14,),),
                    TextButton(onPressed: (){}, child: const Text(
                      'tearms and conditions',style: TextStyle(
                        color: Colors.blue,fontSize: 12,fontWeight: FontWeight.bold
                    ),
                    ))
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
Widget _buildDropdownItem(Country country) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0),
  child:   SizedBox(
    width: 100,
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(
          width: 5.0,
        ),
        Flexible(
          child: Text("+${country.phoneCode}(${country.isoCode})",style: const TextStyle(
            fontSize: 12,fontWeight: FontWeight.bold,
          ),),
        ),
      ],
    ),
  ),
);