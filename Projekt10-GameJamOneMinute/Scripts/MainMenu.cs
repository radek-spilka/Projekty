using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenu : MonoBehaviour
{
    public Animator blackscreen;

    public GameObject player;
    public GameObject moneyBag;

    public float timeLeft = 3f;
    public bool timeIsGoing = false;

    void Awake()
    {
        player.SetActive(true);
        moneyBag.SetActive(true);
    }

    void OnTriggerEnter2D(Collider2D collider)
    {
        if(collider.gameObject.CompareTag("Play")){
            blackscreen.SetBool("IsStart", true);
            timeIsGoing = true;
            player.SetActive(false);
            moneyBag.SetActive(false);
        }

        if(collider.gameObject.CompareTag("Quit")){
            Debug.Log("Quit");
            Application.Quit();
        }   
    }

    void Update()
    {
        if(timeIsGoing){
            timeLeft -= Time.deltaTime;
        } if(timeLeft <= 0){
            timeIsGoing = false;
            timeLeft = 3f;
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
        }
    }
}
