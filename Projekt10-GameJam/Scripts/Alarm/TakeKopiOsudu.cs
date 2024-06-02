using UnityEngine;

public class TakeKopiOsudu : MonoBehaviour
{
    public GameObject table;
    public GameObject table_Broken;
    
    [Header("ExitSign RED")]
    public GameObject exitSignRED;
    public GameObject exitSignRED_Light;

    [Header("ExitSign GREEN")]
    public GameObject exitSignGREEN;
    public GameObject exitSignGREEN_Light;

    public GameObject kopiOsudu;

    private AlarmDetection alarmDetection;

    public bool readyToEscape = false;

    public bool breakingSoundAudio;

    [Header("Siren Audio")]
    public GameObject audioSirene;

    void Awake()
    {
        audioSirene.SetActive(false);
        alarmDetection = GameObject.FindGameObjectWithTag("Alarm").GetComponent<AlarmDetection>();
        breakingSoundAudio = true;
    }

    void OnTriggerEnter2D(Collider2D collision)
    {
        if(collision.gameObject.CompareTag("Player")){
            table.SetActive(false);
            table_Broken.SetActive(true);
            alarmDetection.anotherAlarmActivator = true;
            readyToEscape = true;
            kopiOsudu.SetActive(true);
            audioSirene.SetActive(true);

            if(breakingSoundAudio){
                FindObjectOfType<AudioManager>().Play("BreakingGlass");
                breakingSoundAudio = false;
            }
        }
    }

    void Update()
    {
        if(readyToEscape){
            exitSignRED.SetActive(false);
            exitSignRED_Light.SetActive(false);

            exitSignGREEN.SetActive(true);
            exitSignGREEN_Light.SetActive(true);

        } else if(!readyToEscape){
            exitSignRED.SetActive(true);
            exitSignRED_Light.SetActive(true);

            exitSignGREEN.SetActive(false);
            exitSignGREEN_Light.SetActive(false);
        }
    }
}
