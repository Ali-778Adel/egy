package info.spsolution.esealsdclient


import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import android.os.Build
import android.os.CountDownTimer
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import com.tekartik.sqflite.Constant.TAG
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.ByteArrayInputStream
import java.io.File
import java.io.IOException
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate
import java.util.*
import java.util.concurrent.CountDownLatch
import android.util.Base64

data class ConfigData(
    val signature: String,
    val pinCode: String,
)



class MainActivity : FlutterFragmentActivity() {

    private val CHANNEL = "com.example.native_method_channel"
    private val CHANNEL1 = "configs_channel"
    val latch=CountDownLatch(1)


    var sig:String="";
    var pin:String="";
    var uInputData="";

    var callBackResponse:String=""
    var certificateSignature:String=""
    var startDate:String=""
    var endDate:String=""
    var serialNum:String=""
    var userData:String=""

    @RequiresApi(Build.VERSION_CODES.O)
    override
    fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "onCreate1") {
                val  signature=call.argument<String>("signature")
                val  pinCode=call.argument<String>("pinCode")
                if (signature != null && pinCode !=null) {
                    sig = signature
                    pin = pinCode
                    uInputData = call.argument("userData") ?: "hello"
                }
                    val map = mutableMapOf<String, Any>()
                    map["key1"] = initializeESealSD()
                    map["key2"] = serialNum
                    map["key3"] = startDate
                    map["key4"] = endDate
                    map["key5"] = certificateSignature
                    map["key6"] =userData
//                        userData

                result.success(map)
            }
        }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger,CHANNEL1).setMethodCallHandler{
            call,result ->
            if(call.method=="getConfigs"){
                val  signature=call.argument<String>("signature")
                val  pinCode=call.argument<String>("pinCode")
                val  userInputData=call.argument<String>("userData")

                if (signature != null && pinCode !=null) {
                    sig=signature
                    pin=pinCode
                    uInputData = userInputData ?: "hello"
                }

                println("signature is ${signature}")
                println("signature is ${pinCode}")
                println("userInputData is  ${userInputData}")

                result.success("i recieved method ");
            }
        }
    }


    private val startTime = (15 * 60 * 1000 // 15 MINS IDLE TIME
            ).toLong()
    private val interval = (1 * 1000).toLong()
    val countDownTimer: MyCountDownTimer = MyCountDownTimer(startTime, interval)

    private val REQUEST_EXTERNAL_STORAGE = 1
    private val PERMISSIONS_STORAGE =
        arrayOf(
            Manifest.permission.READ_EXTERNAL_STORAGE,
            Manifest.permission.WRITE_EXTERNAL_STORAGE
        )

    @RequiresApi(Build.VERSION_CODES.O)
    private fun initializeESealSD(): String {
        HelloFromJNI("sdcardpath",pin,sig,uInputData);
        var message = "This test takes a long time, do not rotate."

        // Load the native library
        try {
            System.loadLibrary("esealsdclient")
            Log.d(TAG, "esealsdclient library loaded successfully")
        } catch (e: UnsatisfiedLinkError) {
            Log.e(TAG, "Failed to load esealsdclient library", e)
            return "Failed to load esealsdclient library: ${e.message}"
        }

        // Verify storage permissions
         (verifyStoragePermissions(this))


        // Get the application's data directory on external storage
        val packageName = applicationContext.packageName
        val appPath = "/Android/data/$packageName"
        val sdCards = getRosettaSdCardDataPaths(this, appPath)

        if (sdCards.isEmpty()) {
            return "SPYRUS Rosetta SD not found!"
        }

        // Check Rosetta SmartIO
        val rosettaSmartIOPath = sdCards[0] + appPath
        if (!checkRosettaSmartIO(sdCards[0], appPath)) {
            return "Failed to check Rosetta SmartIO"
        }

        // Set the path to use for MountInfo
        MountInfo.pathtouse = sdCards[0]

        // Test the ESeal SD card
         TestESealSD(rosettaSmartIOPath){result->
             if(result.isNotEmpty()){
                 Log.d(TAG, "$result")
                 message=result
             }
             latch.countDown()
         }
        latch.await()
        return message
    }



    private fun checkRosettaSmartIO(path: String?, appPath: String?): Boolean {

        if (path != null) {
            val file0 = File("$path/SMART_IO.CRD")
            val file = File("$path$appPath/SMART_IO.CRD")
            if (file.exists() == false && file0.exists() == true) {
                try {
                    file.createNewFile()
                } catch (e: Exception) {
                    return false
                }

            }

            return true
        }

        return false
    }


    fun verifyStoragePermissions(activity: Activity) {
        // Check if we have write permission
        val permission =
            ActivityCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE)

        if (permission != PackageManager.PERMISSION_GRANTED) {
            // We don't have permission so prompt the user
            ActivityCompat.requestPermissions(
                activity,
                PERMISSIONS_STORAGE,
                REQUEST_EXTERNAL_STORAGE
            )


        }
    }



    private fun getRosettaSdCardDataPaths(context: Context, appPath: String): Array<String> {


        context.getExternalFilesDirs(null)
        val hashSet = MountInfo.getExternalMounts2()

        //if (!hashSet.isEmpty())
        //    return hashSet.toArray(new String[hashSet.size()]);

        val paths = ArrayList<String>()
        for (file in context.getExternalFilesDirs(null)) { //"external")) {
            if (file != null) {
                //val index = file!!.getAbsolutePath().lastIndexOf(appPath)
                val index = file.getAbsolutePath().lastIndexOf(appPath)
                if (index >= 0) {
                    //var path = file!!.getAbsolutePath().substring(0, index)
                    var path = file.getAbsolutePath().substring(0, index)
                    try {
                        path = File(path).getCanonicalPath()
                        if (path.contains("emulated")) {
                            continue
                        }
                    } catch (e: IOException) {
                        // Keep non-canonical path.
                    }

                    paths.add(path)
                }
            }
        }

        return CheckDrivePaths(
            Merge(
                paths.toTypedArray(),
                hashSet.toArray(arrayOfNulls<String>(0))
            )
        )
    }

    private fun CheckDrivePaths(paths: Array<String>): Array<String> {
        val result = ArrayList<String>(1)
        for (s in paths) {
            val p = "$s/SMART_IO.CRD"
            val f = File(p)
            if (f.exists())
                result.add(s)
        }

        return result.toTypedArray()

    }

    fun Merge(first: Array<String>, second: Array<String>): Array<String> {

        val result = ArrayList<String>(first.size)

        for (s in first) {
            result.add(s)
        }

        for (s in second) {
            if (!result.contains(s))
                result.add(s)
        }

        return result.toTypedArray()
    }


    @RequiresApi(Build.VERSION_CODES.O)
    private fun TestESealSD(sdcardpath: String, callback: (String) -> Unit) {
        Thread(Runnable {
            val tokenInfo = HelloFromJNI(sdcardpath,pin,sig,uInputData);
            if(tokenInfo is TokenInfo) {
                var certificate: X509Certificate? = null;
                if(tokenInfo.getCert()!=null) {
                    certificate =
                        CertificateFactory.getInstance("X.509")
                            .generateCertificate(
                                ByteArrayInputStream(
                                    tokenInfo.getCert()
                                )
                            ) as X509Certificate
                    FinalizeFromJNI();
//                    val encoder= Base64.getEncoder()
//                    val cert=encoder.encodeToString(certificate.encoded)
                    val signatureString = Base64.encodeToString(certificate.signature, Base64.DEFAULT)
                    println("Signature string: $signatureString")
                    certificateSignature=signatureString
                    startDate=certificate.notAfter.toString()
                    endDate=certificate.notBefore.toString()
                    serialNum=certificate.serialNumber.toString()
                    userData= certificate.subjectDN.toString()



// Assuming 'certificate' is your X509Certificate instance


                    println("end date ${certificate.notAfter}")
                    println("start date is ${certificate.notBefore}")
                    println("serialNumber is ${certificate.serialNumber}")
                    println("user data is ${certificate.subjectDN}")  //username == EmailAddress ==  National ID === VATEG we need extrac data here
                    //CN=ناشد ذكرى قزمان, EMAILADDRESS=28701028800073@egypttrust.com, O=ناشد ذكرى قزمان, OU=National ID - 28701028800073, OID.2.5.4.97=VATEG-627824935, C=EG
                    println("signature is !!!  ${signatureString}")
                    callback.invoke("Init\nLogin OK \n" + certificate.subjectDN.name)
                }
                else {
                    callback.invoke("Init\nLogin OK\nNO CERT")
                }
            }
            else {
                callback.invoke(tokenInfo.toString())
            }
        }).start()
    }


    companion object {
      init {
         System.loadLibrary("esealsdclient")
      }
    }
}
class MyCountDownTimer(startTime: Long, interval: Long) :
    CountDownTimer(startTime, interval) {
    override fun onFinish() {
        FinalizeFromJNI();
    }

    override fun onTick(millisUntilFinished: Long) {}

}

external fun HelloFromJNI(path: String,piCode:String,signature :String,userInputData:String): Object
external fun FinalizeFromJNI(): Boolean






