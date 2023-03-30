package info.spsolution.esealsdclient;

import android.os.Build;

import java.io.*;
import java.nio.charset.Charset;
import java.util.*;

/**
 * Parses of /proc/mounts.
 */
public class MountInfo {

    // called from c++
    public static String pathtouse;

    public static String messageMe()
    {

        return pathtouse;

    }

    /**
     * The mounted device (can be "none" or any arbitrary string for virtual
     * file systems).
     */
    public String device;
    /**
     * The path where the file system is mounted.
     */
    public String mountpoint;
    /**
     * The file system.
     */
    public String fs;
    /**
     * The mount options. For most file systems
     */
    public String options;
    /**
     * The dumping frequency for dump(8); see fstab(5).
     */
    public int fs_freq;
    /**
     * The order in which file system checks are done at reboot time; see
     * fstab(5).
     */
    public int fs_passno;

    /**
     * Parses /proc/mounts and gets the mounts.
     *
     * @return the mounts
     */
    public static List<MountInfo> getMounts() {
        try {
            InputStreamReader reader = new InputStreamReader(
                    new FileInputStream("/proc/mounts"),
                    Charset.defaultCharset());
            BufferedReader bufferedReader = new BufferedReader(reader);

            List<MountInfo> mounts = new ArrayList<MountInfo>();

            try {
                String line;
                do {
                    line = bufferedReader.readLine();
                    if (line == null)
                        break;

                    String[] parts = line.split(" ");
                    if (parts.length < 6)
                        continue;
                    MountInfo mount = new MountInfo();
                    mount.device = parts[0];
                    mount.mountpoint = parts[1];
                    mount.fs = parts[2];
                    mount.options = parts[3];
                    mount.fs_freq = Integer.parseInt(parts[4]);
                    mount.fs_passno = Integer.parseInt(parts[5]);
                    mounts.add(mount);
                } while (true);

                return mounts;
            } finally {
                try {
                    bufferedReader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        } catch (IOException e) {
            throw new RuntimeException(
                    "Unable to open /proc/mounts to get mountpoint info");
        }
    }

    /**
     * Parses mount options in the form of "key=value,key=value,key,..."; for
     * example "rw,mode=0664".
     *
     * @param optionsStr
     *            mount options
     * @return Mapping between keys and values (with null values for value-less
     *         keys, e.g. "rw").
     */
    public static Map<String, String> parseOptions(String optionsStr) {
        Map<String, String> optionsDict = new HashMap<String, String>();
        String[] options = optionsStr.split(",");
        for (String option : options) {
            String[] optionParts = option.split("=", 2);
            if (optionParts.length == 0)
                continue;
            else if (optionParts.length == 1)
                optionsDict.put(optionParts[0], null);
            else
                optionsDict.put(optionParts[0], optionParts[1]);
        }
        return optionsDict;
    }

    public static HashSet<String> getExternalMounts() {
        final HashSet<String> out = new HashSet<String>();
        String reg = "(?i).*vold.*(vfat|ntfs|exfat|fat32|ext3|ext4).*rw.*";
        String s = "";
        try {
            final Process process = new ProcessBuilder().command("mount")
                    .redirectErrorStream(true).start();
            process.waitFor();
            final InputStream is = process.getInputStream();
            final byte[] buffer = new byte[1024];
            while (is.read(buffer) != -1) {
                s = s + new String(buffer);
            }
            is.close();
        } catch (final Exception e) {
            e.printStackTrace();
        }

        // parse output
        final String[] lines = s.split("\n");
        for (String line : lines) {
            if (!line.toLowerCase(Locale.US).contains("asec")) {
                if (line.matches(reg)) {
                    String[] parts = line.split(" ");
                    for (String part : parts) {
                        if (part.startsWith("/"))
                            if (!part.toLowerCase(Locale.US).contains("vold"))
                                out.add(part);
                    }
                }
            }
        }
        return out;
    }

    public static HashSet<String> getExternalMounts2() {
        final HashSet<String> out = new HashSet<String>();
        String reg = "(?i).*(storage|vold).*(sdcardfs|vfat).*";
        String s = "";
        try {
            final Process process = new ProcessBuilder().command("mount")
                    .redirectErrorStream(true).start();
            process.waitFor();
            final InputStream is = process.getInputStream();
            final byte[] buffer = new byte[1024];
            while (is.read(buffer) != -1) {
                s = s + new String(buffer);
            }
            is.close();
        } catch (final Exception e) {
            e.printStackTrace();
        }

        int version = Build.VERSION.SDK_INT;
        String versionRelease = Build.VERSION.RELEASE;


        // parse output
        final String[] lines = s.split("\n");
        for (String line : lines) {
            if (!line.toLowerCase(Locale.US).contains("asec")) {
                if (line.matches(reg)) {
                    String[] parts = line.split(" ");
                    if (version <= 23 && !parts[1].contains("emulated"))
                    {
                        out.add(parts[1]);
                    }
                    else {
                        String previous = "";
                        for (String part : parts) {
                            if (previous.equals("on") && !part.contains("emulated")) {
                                out.add(part);
                                break;
                            }
                            previous = part;
                        }
                    }
                }
            }
        }



        return out;
    }

    /***
     * Parses the options field.
     */
    public Map<String, String> parseOptions() {
        return parseOptions(this.options);
    }




}
