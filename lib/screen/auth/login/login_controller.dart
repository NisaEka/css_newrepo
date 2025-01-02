import 'dart:io';
import 'package:css_mobile/base/base_controller.dart';
import 'package:css_mobile/const/color_const.dart';
import 'package:css_mobile/const/textstyle.dart';
import 'package:css_mobile/data/model/auth/get_device_info_model.dart';
import 'package:css_mobile/data/model/auth/input_login_model.dart';
import 'package:css_mobile/data/model/auth/input_pinconfirm_model.dart';
import 'package:css_mobile/data/model/auth/post_login_model.dart';
import 'package:css_mobile/data/storage_core.dart';
import 'package:css_mobile/screen/auth/forgot_password/input_email_screen.dart';
import 'package:css_mobile/screen/auth/login/login_state.dart';
import 'package:css_mobile/screen/auth/signup/signup_otp/signup_otp_screen.dart';
import 'package:css_mobile/screen/auth/signup/signup_screen.dart';
import 'package:css_mobile/screen/dashboard/dashboard_controller.dart';
import 'package:css_mobile/screen/dashboard/dashboard_screen.dart';
import 'package:css_mobile/util/logger.dart';
import 'package:css_mobile/util/snackbar.dart';
import 'package:css_mobile/widgets/dialog/info_dialog.dart';
import 'package:css_mobile/widgets/forms/customfilledbutton.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {
  final state = LoginState();
  var isFirst = true.obs;

  @override
  void onInit() async {
    super.onInit();
    initData();
    state.emailTextField.text;
    state.passwordTextField.text;
  }

  Future<void> initData() async {
    state.lang = await storage.readString(StorageCore.localeApp);
    state.fcmToken = await storage.readString(StorageCore.fcmToken);
    update();
    storage.deleteLogin();
    ValidationBuilder.setLocale(state.lang!);
  }

  void markFirstLoginComplete() {
    isFirst.value = false;
  }

  void showFirstLoginDialog(BuildContext context) {
    if (isFirst.value) {
      Get.dialog(
        AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? whiteColor
              : bgDarkColor,
          // content: state.lang == "id"
          //     ? Image.asset(ImageConstant.tipsKeamanan)
          //     : Image.asset(ImageConstant.safetyTips),
          title: state.lang == "id"
              ? Text(
                  'TIPS AMAN MENGGUNAKAN CSS',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: regular, fontSize: 16),
                )
              : Text(
                  'SAFETY TIPS CSS',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: regular, fontSize: 16),
                ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: state.lang == "id"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildBulletPoint(
                          'Pastikan Anda hanya mengakses tautan CSS: http://css.jne.co.id.',
                          context),
                      _buildBulletPoint(
                          'Menjaga kerahasiaan informasi data Log In AD Pengguna, Kata Sandi, Kata Sandi Email, dan data kredensial lainnya.',
                          context),
                      _buildBulletPoint(
                          'Hindari klik tautan mencurigakan dari Website, WhatsApp dengan alamat nomor yang tidak dikenal',
                          context),
                      _buildBulletPoint(
                          'Tidak menyimpan data kata sandi saat Log In dan pastikan melakukan Log Out setelah selesai menggunakan CSS.',
                          context),
                      _buildBulletPoint(
                          'Amankan Komputer dan Jaringan yang digunakan dengan mengaktifkan Spam Blocker, menggunakan Antivirus, dan Konfigurasi Firewall.',
                          context),
                      _buildBulletPoint(
                          'Waspada terhadap email phishing, website phishing dan pastikan teliti serta validasi kembali transaksi anda.',
                          context),
                      _buildBulletPoint(
                          'Jangan pernah memberikan PIN/OTP/PASSWORD/PIN CSS/Kode OTP kepada siapapun. Pihak JNE tidak pernah meminta PIN/OTP/PASSWORD/PIN CSS/Kode OTP dari Customer.',
                          context),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildBulletPoint(
                          'Please ensure that you access only the CSS link: http://css.jne.co.id.',
                          context),
                      _buildBulletPoint(
                          'Please ensure the confidentiality of your Company ID, User ID, Password, Email Password, and other credential data.',
                          context),
                      _buildBulletPoint(
                          'Avoid engaging with suspicious links from unfamiliar websites or WhatsApp messages received from unknown numbers.',
                          context),
                      _buildBulletPoint(
                          'Do not retain password data during the login process and ensure that you log out after use.',
                          context),
                      _buildBulletPoint(
                          'Ensure the security of your computer and network by activating the Spam Blocker and configuring Antivirus and Firewall settings.',
                          context),
                      _buildBulletPoint(
                          'Exercise caution regarding phishing emails and websites. Ensure that you carefully re-validate your transactions.',
                          context),
                      _buildBulletPoint(
                          'Please do not share your PIN, OTP, Password, or any other sensitive information with anyone. JNE will never request your PIN, OTP, Password, or any other secure codes from customers.',
                          context),
                    ],
                  ),
          ),
//           content: state.lang == "id"
//               ? Text('''
// - Pastikan Anda hanya mengakses tautan CSS: http://css.jne.co.id.
// - Menjaga kerahasiaan informasi data Log In AD Pengguna, Kata Sandi, Kata Sandi Email, dan data kredensial lainnya.
// - Hindari klik tautan mencurigakan ari Website, WhatsApp dengan alamat nomor yang tidak dikenal
// - Tidak menyimpan data kata sandi dsaat Log In dan dipastikan melakukan Log Out setelah selesai menggunakan CSS.
// - Amankan Komputer dan Jaringan yang digunakan dengan mengaktifkan Spam Blocker, menggunakan Antivirus, dan Konfigurasi Firewall.
// - Waspada terhadap email phising, website phising dan pastikan teliti serta validasi kembali transaksi anda.
// - Jangan pernah memberikan PIN/OTP/PASSWORD/PIN CSS/Kode OTP kepada siapapun. Pihak JNE tidak pernah meminta PIN/OTP/PASSWORD/PIN CSS/Kode OTP dari Customer.''',
//                   style: Theme.of(context)
//                   .textTheme
//                   .titleLarge
//                   ?.copyWith(fontWeight: regular, fontSize: 12),
//                 )
//               : Text('''
// - Please ensure that you access only the CSS link: http://css.jne.co.id.
// - Please ensure the confidentiality of your Company ID, User ID, Password, Email Password, and other credential data.
// - Avoid engaging with suspicious links from unfamiliar websites or WhatsApp messages received from unknown numbers.
// - Do not retain password data during the login process and ensure that you log out after use.
// - Ensure the security of your computer and network by activating the Spam Blocker and configuring Antivirus and Firewall settings.
// - Exercise caution regarding phishing emails and websites. Ensure that you carefully re-validate your transactions.
// - Please do not share you PIN,OTP, Password, or any other sensitive information with anyone. JNE will never request your PIN, OTP, Password, or any other secure codes from customers.''',
//                   style: Theme.of(context)
//                       .textTheme
//                       .titleLarge
//                       ?.copyWith(fontWeight: regular, fontSize: 12),
//                 ),
          actions: [
            CustomFilledButton(
              radius: 50,
              color: primaryColor(context),
              title: 'Saya telah membaca & memahami'.tr,
              onPressed: () {
                markFirstLoginComplete();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    }
  }

  Widget _buildBulletPoint(String text, BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Icon(Icons.insert_comment),
        ),
        // const Padding(
        //   padding: EdgeInsets.only(top: 6.0),
        //   child: Icon(Icons.circle, size: 5),
        // ), // Bullet point icon
        const SizedBox(width: 8), // Space between bullet and text
        Expanded(
          child: Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: regular, fontSize: 12),
          ),
        ),
      ],
    );
  }

  bool onPop() {
    DateTime now = DateTime.now();
    if (state.currentBackPressTime == null ||
        now.difference(state.currentBackPressTime!) >
            const Duration(seconds: 2)) {
      state.currentBackPressTime = now;
      AppSnackBar.custom(
        message: 'Double click back button to exit'.tr,
        backgroundColor: greyColor.withOpacity(0.8),
        icon: const Icon(
          Icons.info,
          color: whiteColor,
        ),
        durationInSeconds: 3,
        snackPosition: SnackPosition.BOTTOM,
        snackStyle: SnackStyle.GROUNDED,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        padding: const EdgeInsets.all(10),
        messageText: null,
      );
      state.pop = false;
      update();
      return false;
    }
    state.pop = true;
    update();
    Get.off(() => const DashboardScreen());
    return true;
  }

  Widget showIcon = const Icon(
    Icons.remove_red_eye,
  );

  Future<void> doLogin(BuildContext context) async {
    state.isLoading = true;
    update();
    try {
      await auth
          .postLogin(
        InputLoginModel(
          email: state.emailTextField.text,
          password: state.passwordTextField.text,
          device: await getDeviceinfo(state.fcmToken ?? ''),
          // this location service sometimes cause error in emulator
          // NOTE: uncomment this line if you want to use location service
          // coordinate: await getCurrentLocation(),
        ),
      )
          .then((value) async {
        if (value.code == 201) {
          await storage
              .saveToken(
                value.data?.token?.accessToken,
                value.data?.menu ?? MenuModel(),
                value.data?.token?.refreshToken,
              )
              // .then((_) async => auth
              //     .postFcmToken(
              //       await getDeviceinfo(state.fcmToken ?? '') ?? DeviceModel(),
              //     )
              //     .then((value) async => value.code == 201
              //         ? await auth.updateDeviceInfo(
              //             await getDeviceinfo(state.fcmToken ?? '') ?? DeviceModel(),
              //           )
              //         : null))
              .then((_) => Get.delete<DashboardController>())
              .then((_) => Get.offAll(() => const DashboardScreen()));
        } else if (value.code == 403) {
          Get.dialog(
            InfoDialog(
              infoText: "Silahkan aktivasi akun terlebih dahulu".tr,
              nextButton: () =>
                  Get.off(() => const SignUpOTPScreen(), arguments: {
                'email': state.emailTextField.text,
                'isActivation': true,
              }),
            ),
          );
        } else if (value.code == 401) {
          AppSnackBar.error("login_failed".tr);
        } else if (value.message == "Email not verified") {
          try {
            await auth
                .postRegistPinResend(
                    InputPinconfirmModel(email: state.emailTextField.text))
                .then((value) {
              if (value.code == 201) {
                AppSnackBar.success('Silahkan cek email anda'.tr);
                Get.to(() => const SignUpOTPScreen(), arguments: {
                  'email': state.emailTextField.text,
                  'isActivation': true,
                });
              }
            });
          } catch (e) {
            AppLogger.e('error resend pin $e');
          }
        } else {
          AppSnackBar.error(value.message.toString());
        }
      });
    } catch (e) {
      AppLogger.e('error login $e');
      AppSnackBar.error('Login failed: $e');
    }
    state.isLoading = false;
    update();
    // Get.offAll(DashboardScreen());
  }

  Future<DeviceModel?> getDeviceinfo(String token) async {
    var deviceInfo = DeviceInfoPlugin();
    // var user = UserModel.fromJson(await storage.readData(StorageCore.basicProfile));
    if (Platform.isIOS) {
      // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      var systemName = iosDeviceInfo.systemName;
      var version = iosDeviceInfo.systemVersion;

      return DeviceModel(
        fcmToken: token,
        deviceId: iosDeviceInfo.identifierForVendor,
        versionOs: '$systemName $version',
      );
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      var release = androidDeviceInfo.version.release;
      return DeviceModel(
        fcmToken: token,
        deviceId: androidDeviceInfo.id,
        versionOs: 'Android $release',
      );
    }
    return null;
  }

  Future cekToken() async {
    state.isLoading = true;
    update();
    String? token = await storage.readAccessToken();
    AppLogger.e('token : $token');
    if (token != null) {
      Get.delete<DashboardController>()
          .then((_) => Get.offAll(() => const DashboardScreen()));
      // String all = await storage.readString(StorageCore.allowedMenu);
      // AllowedMenu menu = AllowedMenu.fromJson(jsonDecode(all));
      // print(menu.beranda);
    }
    state.isLoading = false;
    update();
  }

  Future<Coordinate> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    Position position;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    position = await Geolocator.getCurrentPosition();
    return Coordinate(lat: position.latitude, lng: position.longitude);
  }

  showPassword() {
    state.isObscurePasswordLogin
        ? state.isObscurePasswordLogin = false
        : state.isObscurePasswordLogin = true;
    state.isObscurePasswordLogin != false
        ? showIcon = const Icon(
            Icons.visibility,
          )
        : showIcon = const Icon(
            Icons.visibility_off,
          );
    update();
  }

  forgotPassword() {
    // Get.delete<LoginController>();
    state.emailTextField.clear();
    state.passwordTextField.clear();
    Get.to(
      () => const InputEmailScreen(),
      arguments: {'isChange': false},
    );
  }

  register() {
    state.emailTextField.clear();
    state.passwordTextField.clear();
    Get.to(() => const SignUpScreen())?.then(
      (_) => state.formKey.currentState?.reset(),
    );
  }
}
