import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_egypt_trust/models/utils/themes/app_slider_images.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/follow_order_screen.dart';
import 'package:fl_egypt_trust/ui/screens/main/payment/screens/payment_first_form_screen.dart';
import 'package:fl_egypt_trust/ui/screens/sd_screens/pages/configs_screen.dart';
import 'package:fl_egypt_trust/ui/screens/widgets/toast_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_unicons/flutter_unicons.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sizer/sizer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../../di/dependency_injection.dart';
import '../../../../../models/utils/app_preference.dart';
import '../../../../../models/utils/themes/app_icons.dart';
import '../../../../../models/utils/themes/colors.dart';
import '../../../../../models/utils/themes/themes_bloc/bloc.dart';
import '../../../../../repository/common_function/url_launcher.dart';
import '../../../widgets/connection_error widget.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/service_item.dart';
import '../../home/subs/certifications/screen_certification.dart';
import '../../home/subs/certifications/screen_order_inquiry.dart';
import '../../payment/screens/payment_parent_screen.dart';
import '../redesign_bloc/bloc.dart';
import '../redesign_bloc/events.dart';
import '../redesign_bloc/states.dart';
import 'buySealPage.dart';
import 'new_home_screen_shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreenArgs{
  final String?issauanceCiretificationTxt;
  final String?ordersQueryTxt;
  // final String?paymentTxt
  HomeScreenArgs({this.issauanceCiretificationTxt,this.ordersQueryTxt});
}

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  final pageController = PageController();
  int activeIndex = 0;

 String appLocal=sl<ThemeBloc>().appLocal;

 String getTrans({required  GetHomeTranslatorsState state,required String txtKey}){
   if(appLocal=='ar-SA'){
    return "${state.publicTranslatorsEntity!.where((element) => element.key == txtKey).first.val}";
   }else if(appLocal=='en-US'){
    return "${state.publicTranslatorsEntity!.where((element) => element.key == txtKey).first.valEn}";
   }else{
     return "لا يوجد نص";
   }
 }

  // final icons = sl<ThemeBloc>().appIcons;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context: context).call(),
      body:
          BlocBuilder<HomeViewBloc, HomeViewStates>(builder: (context, state) {
        if (state is GetHomeTranslatorsState) {
          switch (state.homeViewResponseStatus) {
            case HomeViewResponseStatus.success:
              {

                return SingleChildScrollView(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.sp, vertical: 8.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCarousel(),
                      _buildServicesSection(state),
                      _buildContactUsLabel(state),
                      _buildSocialSection(),
                    ],
                  ),
                );
              }
            case HomeViewResponseStatus.error:
              {
                showToastWidget(
                    CustomToastWidget(
                      toastStatus: ToastStatus.error,
                      toastContent: state.message,
                    ),
                    position: ToastPosition.bottom);
                return Center(
                  child: RetryContainer(
                    onRetry: () {
                      BlocProvider.of<HomeViewBloc>(context)
                          .add(GetHomeTranslatorsEvent());
                    },
                    errorMessage: state.message ?? 'un know error',
                  ),
                );
              }
            case HomeViewResponseStatus.loading:
              {
                return const ShimmerHomeScreen();
              }
            default:
              {
                return const Placeholder();
              }
          }
        } else {
          return const Placeholder();
        }
      }),
    );
  }

  /// build carousel
  Widget _buildCarousel() {
    return Container(
        height: 180.sp,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Palette.textHint,
          borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        ),
        child: Stack(
          children: [
            PageView(
              reverse: true,
              controller: pageController,
              children: List.generate(AppSliderImages.carouselImages.length, (index) => CachedNetworkImage(
                imageUrl: AppSliderImages.carouselImages[index],
                fit: BoxFit.fill,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    SizedBox(
                      height: 12.sp,
                        width: 12.sp,
                        child: LinearProgressIndicator(value: downloadProgress.progress)),
                errorWidget: (context, url, error) =>const Icon(Icons.error),
              ), ),
              onPageChanged: (index) {
                setState(() {
                  activeIndex = index;
                });
                pageController.animateToPage(index,
                    duration: const Duration(seconds: 1), curve: Curves.linear);
              },
            ),
            PositionedDirectional(
              bottom: 16.sp,
              end: MediaQuery.of(context).size.width * .28.sp,
              child: AnimatedSmoothIndicator(
                duration: const Duration(seconds: 1),
                activeIndex: activeIndex,
                count: AppSliderImages.carouselImages.length,
                effect: CustomizableEffect(
                  activeDotDecoration: DotDecoration(
                    width: 10,
                    height: 10,
                    color: Palette.mainGreen,
                    rotationAngle: 180,
                    // verticalOffset: -10,
                    borderRadius: BorderRadius.circular(5),
                    dotBorder:  DotBorder(
                      padding: 2,
                      width: 2,
                      color: Palette.mainGreen,
                    ),
                  ),
                  dotDecoration: DotDecoration(
                    width: 10,
                    height: 10,
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(5),
                    verticalOffset: 0,
                  ),
                  spacing: 6.0,
                  inActiveColorOverride: (i) => Palette.white,
                ),
                onDotClicked: (index) {
                  setState(() {
                    activeIndex = index;
                  });
                  pageController.animateToPage(index,
                      duration: const Duration(seconds: 1),
                      curve: Curves.linear);
                },
              ),
            )
          ],
        ));
  }

  /// build services
  Widget _buildServicesSection(GetHomeTranslatorsState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 16.sp, bottom: 4.0.sp, right: 8.sp),
          child: Text(
              getTrans(state: state, txtKey:'servicesTxt'),
            style: Theme.of(context).textTheme.bodyLarge
            // textAlign: TextAlign.center
          ),
        ),
        CustomServiceItem(
          iconData: FontAwesomeIcons.fileContract,
          serviceName:getTrans(state: state, txtKey: 'servicesItem1Txt'),
          imageUrl:AppIcons.issuanceCertificationIcon,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ScreenCertification(),
                settings: RouteSettings(
                  arguments: HomeScreenArgs(
                    issauanceCiretificationTxt:getTrans(state: state, txtKey: 'servicesItem1Txt')
                  )
                )
              ),
            );
          },
        ),
        CustomServiceItem(
          iconData: FontAwesomeIcons.searchengin,
          serviceName:getTrans(state: state, txtKey: 'servicesItem2Txt'),
          imageUrl: AppIcons.ordersQueryIcon,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ScreenOrderInquiry()
             ,     settings: RouteSettings(
              arguments: HomeScreenArgs(
              ordersQueryTxt:getTrans(state: state, txtKey: 'servicesItem2Txt'),
            )
            )
              ),
            );
          },
        ),
        CustomServiceItem(
          iconData: FontAwesomeIcons.moneyCheckDollar,
          serviceName:getTrans(state: state, txtKey: 'servicesItem3Txt'),
          imageUrl: AppIcons.sealSignatureIcon,
          onTap: ()async{
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentControllerScreen()));
            // if(await checkPaymentToken()){
            //
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>const PaymentControllerScreen()));
            // }else{
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => const PaymentFirstFormScreen()));
            // }

          },
        ),
        CustomServiceItem(
          iconData: FontAwesomeIcons.moneyCheckDollar,
          serviceName:'اصدار توقيع',
          imageUrl: AppIcons.sealSignatureIcon,
          onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const BuySealPage()));


          },
        ),
      ],
    );
  }

  /// build contactUs label
  Widget _buildContactUsLabel(GetHomeTranslatorsState state) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.sp),
      child: Row(
        children: [
          Expanded(
              child: Container(
                  height: 2,
                  decoration: const BoxDecoration(color: Color(0x75285397)))),
          Expanded(
              child: Text(
                getTrans(state: state, txtKey: 'contactUsTxt'),

                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center)),
          Expanded(
              child: Container(
                  height: 2,
                  decoration: const BoxDecoration(color: Color(0x75285397)))),
        ],
      ),
    );
  }

  /// build contact us
  Widget _buildSocialSection() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.sp),
      child: Row(
        children: [
          Expanded(
              child: IconButton(
            onPressed: () {
              launchUrl1('https://www.youtube.com/channel/UCAL0jbJDdWMKfq4vcE-zUjA');
            },
            icon: Unicon(
              Unicons.uniYoutube,
              color: Palette.colorRed,
              size: 20.sp,
            ),
          )),
          Expanded(
              child: IconButton(
            onPressed: () {
              launchUrl1('https://www.instagram.com/egypt.trust/');
            },
            icon: Unicon(
              Unicons.uniInstagramAlt,
              color: Palette.instagram,
              size: 20.sp,
            ),
          )),
          Expanded(
              child: IconButton(
            onPressed: () {
              launchUrl1('https://www.facebook.com/DigitalSignatureET/');

            },
            icon: Unicon(
              Unicons.uniFacebook,
              color: Palette.facebook,
              size: 20.sp,
            ),
          )),
          Expanded(
              child: IconButton(
            onPressed: () {
              launchUrl1('https://www.linkedin.com/company/egypt-trust/');
            },
            icon: Unicon(
              Unicons.uniLinkedin,
              color: Palette.twitter,
              size: 20.sp,
            ),
          )),
        ],
      ),
    );
  }

 Future<bool> checkPaymentToken()async{
    final token=await sl<AppPreference>().getUserPaymentToken();
    if(token!=null&&token.isNotEmpty){
      return true;
    }else{
      return false;
    }
  }



}
