using UnityEngine;
using TMPro;
using UnityEngine.SceneManagement;

public class AlarmDetection : MonoBehaviour
{
    private TMP_Text alarmCountDown;
    private LevelManagment levelManagment;

    private Animator alarmAnim;

    public float alarmTime = 10f;
    public bool anotherAlarmActivator = false;
    static bool alarmIsOn = false;

    [Header("Siren Audio")]
    public GameObject audioSirene;

    void Awake()
    {
        audioSirene.SetActive(false);

        alarmIsOn = false;
        anotherAlarmActivator = false;

        alarmCountDown = GameObject.FindGameObjectWithTag("AlarmCountDownText").GetComponent<TMP_Text>();
        levelManagment = GameObject.FindGameObjectWithTag("Canvas").GetComponent<LevelManagment>();
        alarmAnim = GetComponent<Animator>();

        alarmCountDown.text = " ";
    }

    void OnCollisionEnter2D(Collision2D collision)
    {
        if(collision.gameObject.CompareTag("Player") || collision.gameObject.CompareTag("MoneyBag")){
            alarmIsOn = true;
            audioSirene.SetActive(true);
        }
    }

    void Update()
    {

        if(anotherAlarmActivator){
            alarmIsOn = true;
        }

        if(levelManagment.restartLevel == true){
            anotherAlarmActivator = false;
            alarmIsOn = false;
        }

        if(alarmIsOn){
            alarmCountDown.text = alarmTime.ToString("0");
            alarmTime -= Time.deltaTime;
            alarmAnim.SetBool("AlarmIsOn", true);
        } if(alarmTime <= 0f){
            alarmIsOn = false;
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }
    }
}
