package info.spsolution.esealsdclient;


import androidx.annotation.Keep;

@Keep
public class TokenInfo {
    private byte[] _cert;
    private byte[] _certId;
    private String serialnumber;
    private String label;
    private String model;
    private String manufacturerID;
    private Boolean isInit;
    private Boolean isUserInit;
    private byte[] cert;
    private byte[] certId;

    public TokenInfo(byte[] cert,byte[] certId, String serialnumber, String label, String model, String manufacturerID, boolean isInit, boolean isUserInit) {
        this.serialnumber = serialnumber.trim();
        this.label = label.trim();
        this.model = model.trim();
        this.manufacturerID = manufacturerID.trim();
        this.isInit = isInit;
        this.isUserInit = isUserInit;
        this.cert=cert;
        this.certId=certId;
    }
    public byte[] getCert() {
        return this.cert;
    }
    public byte[] getCertId() {
        return this.certId;
    }

    public String getSerialnumber() {
        return this.serialnumber;
    }

    public String getLabel() {
        return this.label;
    }

    public String getModel() {
        return this.model;
    }

    public String getManufacturerID(){
        return  this.manufacturerID;
    }

    public boolean IsInit(){
        return this.isInit;
    }

    public boolean IsUserInit(){
        return this.isUserInit;
    }
}
