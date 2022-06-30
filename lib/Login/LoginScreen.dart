import 'package:algorizainternship/Componets/TextFormField.dart';
import 'package:algorizainternship/Style/Colors.dart';
import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery=MediaQuery.of(context).size;
   var emailController= TextEditingController();
    return Scaffold(
     appBar: AppBar(
       automaticallyImplyLeading: true,
       toolbarHeight: mediaQuery.height/4,
       flexibleSpace: Container(
         decoration: const BoxDecoration(
             image: DecorationImage(
                 image: AssetImage('assets/image/background.jpg'),
                 fit: BoxFit.fitWidth
             )
         ),
       ),
     ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
             Text('Welcome to Fashion Daily ',
               style: Theme.of(context).textTheme.caption!.copyWith(fontSize:14 ),),
             const SizedBox(height: 20,),
             Text('Sign in ',
               style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.black),),
            const SizedBox(height: 20,),
             Text('Phone Number ',
               style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.grey,fontSize: 16,fontWeight: FontWeight.bold),),
            Row(
              children: [
                Expanded(
                  child: MyTextFormField(
                    textInputFormat: '[0-9]',
                    backgroundColor: Colors.white,
                    borderColor: const Color(0xffebedee),
                    control:emailController ,
                    isPassword: false,
                    hint: 'Eg 035338114',
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
                ),

              ],
            ),

          ],
        ),
      ),
    );
  }
}
Widget _buildDropdownItem(Country country) => Padding(
  padding: const EdgeInsets.symmetric(horizontal: 10.0),
  child:   Container(
    width: 100,
    child: Row(
      children: <Widget>[
        CountryPickerUtils.getDefaultFlagImage(country),
        const SizedBox(
          width: 2.0,
        ),
        Flexible(
          flex: 1,
          child: Text("+${country.phoneCode}(${country.isoCode})",style: const TextStyle(
            fontSize: 14,fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis
          ),),
        ),
      ],
    ),
  ),
);