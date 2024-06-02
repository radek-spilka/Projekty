using UnityEngine;
using UnityEngine.SceneManagement;

public class EndMenu : MonoBehaviour
{
    public Animator blackscreen;

    public float timeLeft = 5f;
    public bool timeIsGoing = false;

    void Update()
    {
        if(Input.GetMouseButtonDown(0)){
            blackscreen.SetBool("IsEnd", true);
            timeIsGoing = true;
        }

        if(timeIsGoing){
            timeLeft -= Time.deltaTime;
        } if(timeLeft <= 0){
            timeIsGoing = false;
            timeLeft = 5f;
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex - 2);
        }
    }
}
