package info.spsolution.esealsdclient

import android.Manifest
import android.app.Activity
import android.content.Context
import android.content.pm.PackageManager
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.os.CountDownTimer
import android.widget.TextView
import androidx.core.app.ActivityCompat
import java.io.ByteArrayInputStream
import java.io.File
import java.io.IOException
import java.security.cert.CertificateFactory
import java.security.cert.X509Certificate
import java.util.ArrayList

class MainActivity : AppCompatActivity() {

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

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        HelloFromJNI("sddfd")
        val tv : TextView = findViewById(R.id.textView) as TextView;
        tv.text = "This test takes a long time, do not rotate.";

        verifyStoragePermissions(this);

        val thePackage = this.applicationContext.packageName
        val appPath = "/Android/data/" + thePackage.toString();

        val sdcards = getRosettaSdCardDataPaths(this, appPath)

//        if (sdcards.isEmpty()) {
//            tv.text = "SPYRUS Rosetta SD not found!";
//            return;
//        }

        checkRosettaSmartIO(sdcards[0], appPath)

        MountInfo.pathtouse = sdcards[0]

        tv.text = "Please wait";

//        TestESealSD(tv, MountInfo.pathtouse+appPath);
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

    private fun TestESealSD(tv: TextView, sdcardpath: String): Boolean {
        Thread(Runnable {
            val tokenInfo = HelloFromJNI(sdcardpath);
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
                    tv.post { tv.text = "Init\nLogin OK \n" + certificate.subjectDN.name };
                }
                else {
                    tv.post { tv.text = "Init\nLogin OK\nNO CERT" };
                }
            }
            else
            {
                tv.post { tv.text = tokenInfo.toString() };
            }
        }).start();
        return true;
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

external fun HelloFromJNI(path: String): Object
external fun FinalizeFromJNI(): Boolean