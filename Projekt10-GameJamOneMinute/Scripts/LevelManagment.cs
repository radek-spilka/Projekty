using UnityEngine;
using UnityEngine.SceneManagement;
using TMPro;

public class LevelManagment : MonoBehaviour
{
    [Header("Hint")]
    public Animator hintArrows;
    public GameObject leftArrow;
    public GameObject rightArrow;

    [Header("PlayerParts")]
    public GameObject playerFull;
    public GameObject playerOrgansStay;

    public GameObject kopiOsudu;

    [Header("LevelSettings")]
    public bool restartLevel = false;

    private TMP_Text timerTMP; 
    public float timerNumber = 60f;

    [Header("Time")]
    public float timeLeft = 2f;
    public bool timeIsGoing = false;

    public float timeLeft2 = 3.25f;
    public bool timeIsGoing2 = false;

    public bool deathSoundisReady = true;
    public bool hintSoundisReady;

    void Awake()
    {
        if(SceneManager.GetActiveScene().buildIndex == 1){
            timerTMP = GameObject.FindGameObjectWithTag("Timer").GetComponent<TMP_Text>();
            leftArrow.SetActive(false);
            rightArrow.SetActive(false);
            hintSoundisReady = true;
        }
    }

    void Update()
    {
        if(restartLevel == false){
            timerNumber -= Time.deltaTime;
        }
        
        if(SceneManager.GetActiveScene().buildIndex == 1){
            timerTMP.text = timerNumber.ToString("0");
        }

        if(timerNumber <= 0){
            timerTMP.text = "Time out!";
            restartLevel = true;
            timeIsGoing = true;
        }

        if(Input.GetKeyDown(KeyCode.R) && deathSoundisReady){
            deathSoundisReady = false;
            FindObjectOfType<AudioManager>().Play("Death");
        }

        if(Input.GetKeyDown(KeyCode.R)){
            restartLevel = true;
            timeIsGoing = true;
        }

        if(Input.GetKeyDown(KeyCode.H) && hintSoundisReady){
            FindObjectOfType<AudioManager>().Play("MenuPauseHint");
            hintSoundisReady = false;
        }

        if(Input.GetKeyDown(KeyCode.H)){
            hintArrows.SetBool("IsHint", true);
            leftArrow.SetActive(true);
            rightArrow.SetActive(true);

            timeIsGoing2 = true;
        }

        if(Input.GetKeyDown(KeyCode.M)){
            FindObjectOfType<AudioManager>().Play("MenuPauseHint");
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex - 1);
        }  

        if(timeIsGoing && deathSoundisReady){
            FindObjectOfType<AudioManager>().Play("Death");
            deathSoundisReady = false;
        }

        if(timeIsGoing){
            timeLeft -= Time.deltaTime;
            playerOrgansStay.transform.position = playerFull.transform.position;
            playerFull.SetActive(false);
            playerOrgansStay.SetActive(true);
        } if(timeLeft <= 0){
            timeIsGoing = false;
            playerOrgansStay.SetActive(false);
            deathSoundisReady = true;
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        }

        if(timeIsGoing2){
            timeLeft2 -= Time.deltaTime;
        } if (timeLeft2 <= 0){
            hintSoundisReady = true;
            timeIsGoing2 = false;
            leftArrow.SetActive(false);
            rightArrow.SetActive(false);
            timeLeft2 = 3.25f;
        }
    }
}
