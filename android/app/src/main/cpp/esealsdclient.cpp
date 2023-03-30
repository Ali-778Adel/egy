#include <jni.h>
#include <string>
#include <dlfcn.h>
#include <stdio.h>

using namespace std;

void* lib;

extern "C"
JNIEXPORT jobject JNICALL
Java_info_spsolution_esealsdclient_MainActivityKt_HelloFromJNI(JNIEnv *env, jclass clazz, jstring jpath) {
    string returnmsg="";

    lib = dlopen("libeSealSD.so", RTLD_LAZY);

    string path = env->GetStringUTFChars(jpath, NULL);

    if (!lib) {
        fprintf(stderr, "Error loading pkcs#11 so: %s\n", dlerror());
        return env->NewStringUTF(dlerror());;
    }
    typedef string (*eSealSD_testFunc)(string);
    typedef bool (*eSealSD_initPKCS)(string);
    typedef void (*eSealSD_getFirstSlotInfo)(char *,char *,char *,char *, bool *, bool *, char *, int *, char *,int *);
    typedef int (*eSealSD_loginFirstSlot)(string,string);
    typedef bool (*eSealSD_acquireSessionPrivKey)();
    typedef string (*eSealSD_signCades)(string);

    eSealSD_testFunc testFunc = (eSealSD_testFunc)dlsym(lib,"eSealSD_testFunc");
    eSealSD_initPKCS initPKCS = (eSealSD_initPKCS)dlsym(lib,"eSealSD_initPKCS");
    eSealSD_getFirstSlotInfo getFirstSlotInfo = (eSealSD_getFirstSlotInfo)dlsym(lib,"eSealSD_getFirstSlotInfo");
    eSealSD_loginFirstSlot loginFirstSlot = (eSealSD_loginFirstSlot)dlsym(lib,"eSealSD_loginFirstSlot");
    eSealSD_acquireSessionPrivKey acquireSessionPrivKey = (eSealSD_acquireSessionPrivKey)dlsym(lib,"eSealSD_acquireSessionPrivKey");
    eSealSD_signCades signCades = (eSealSD_signCades)dlsym(lib,"eSealSD_signCades");

    string test = testFunc("hello from the other side");

    bool  init = initPKCS(path);
    if(init) {
        returnmsg +="init OK";
        jclass tokenInfoClass = env->FindClass("info/spsolution/esealsdclient/TokenInfo");
        jmethodID tokenInfoConstructor =
                env->GetMethodID(tokenInfoClass, "<init>",
                                 "([B[BLjava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ZZ)V");

        char serialNumber[16]= {'\0'}, label[32]= {'\0'}, model[16]= {'\0'}, manufacturerID[32]= {'\0'};
        bool tinit, pininit;
        char tcert[2000] = {'\0'}, tcertId[100] = {'\0'};
        int tcertlen = 0, tcertIdlen = 0;

        getFirstSlotInfo(serialNumber, label, model, manufacturerID, &tinit, &pininit, tcert, &tcertlen,
                         tcertId, &tcertIdlen);

        jstring serialNumberstr = env->NewStringUTF(string(serialNumber,16).c_str());
        jstring labelstr = env->NewStringUTF( string( label, 32).c_str());
        jstring modelstr = env->NewStringUTF( string( model, 16).c_str());
        jstring manufacturerIDstr = env->NewStringUTF( string( manufacturerID, 32).c_str());

        int login = loginFirstSlot("11112222","oynrqImfTCo3x4lC6mWDdcTAxbErnMUMs/2O21i/63Z3TXZiqPVRjNwM6YVy1IzK7VgQGKqe9Nwe72SISwwIz4Ct0r3SgHO25SX/Vhoqc+4r62rvjKDVMWqlh8YHOqVpusTyzapTNRo6Xvyfa3QyeBDfjnwPiA9MiLfJE6lh1cQe7zE9PEdnSTGF3wIeU92N8lKRlAdTwxZ7uZGZuUqzzSnbKFsSRuyu21jA6yNMe7VdDm5B7nEwmfQ/8iD+syzqOsSDWGXRaGavqwMPmkO+4EA/hGAPrhUbyknNWzfxilM3yuWih3GSzFy83SBqTfhYq2xY9T4nIhskQMv4IOEQKQ==");
        /*
         * 1 pin ok, lic ok
         * 0 pin error, lic ok
         * -1 lic error
         * -2 lic check failed
         * -3 lic expired
         */
        if(login==1) {
            returnmsg +="\nLogin OK";
            getFirstSlotInfo(serialNumber, label, model, manufacturerID, &tinit, &pininit, tcert, &tcertlen,
                             tcertId, &tcertIdlen);

            serialNumberstr = env->NewStringUTF(string(serialNumber,16).c_str());
            labelstr = env->NewStringUTF( string( label, 32).c_str());
            modelstr = env->NewStringUTF( string( model, 16).c_str());
            manufacturerIDstr = env->NewStringUTF( string( manufacturerID, 32).c_str());

            jbyteArray certBytes = NULL, certIdBytes = NULL;
            if (tcert != NULL && tcertId != NULL && tcertlen != 0 && tcertIdlen != 0) {
                certBytes = env->NewByteArray(tcertlen);
                env->SetByteArrayRegion(certBytes, 0, tcertlen, (const jbyte *) tcert);
                certIdBytes = env->NewByteArray(tcertIdlen);
                env->SetByteArrayRegion(certIdBytes, 0, tcertIdlen, (const jbyte *) tcertId);

                jobject tokeninfo = env->NewObject(tokenInfoClass, tokenInfoConstructor,
                                       certBytes,
                                       certIdBytes,
                                       serialNumberstr,
                                       labelstr,
                                       modelstr,
                                       manufacturerIDstr,
                                       init,
                                       pininit);
                bool pk =acquireSessionPrivKey();
                string sign = signCades("HelloSign");

                return tokeninfo;
            }
            return env->NewObject(tokenInfoClass, tokenInfoConstructor,
                                   certBytes,
                                   certIdBytes,
                                   serialNumberstr,
                                   labelstr,
                                   modelstr,
                                   manufacturerIDstr,
                                   init,
                                   pininit);
        }
        else
            returnmsg +="\n Login Failed " + to_string(login);
    }
    else
        returnmsg +="init failed";

    return env->NewStringUTF(returnmsg.c_str());
}
extern "C"
JNIEXPORT jboolean JNICALL
Java_info_spsolution_esealsdclient_MainActivityKt_FinalizeFromJNI(JNIEnv *env, jclass clazz) {

    if (!lib) {
        return true;
    }
    typedef bool (*eSealSD_finalize)();
    eSealSD_finalize finalize = (eSealSD_finalize)dlsym(lib,"eSealSD_finalize");

    bool  fin = finalize();

    dlclose(lib);

    return fin;
}