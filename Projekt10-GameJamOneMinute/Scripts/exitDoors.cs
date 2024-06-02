using UnityEngine;
using UnityEngine.SceneManagement;

public class exitDoors : MonoBehaviour
{
    private TakeKopiOsudu takeKopiOsudu;

    void Awake()
    {
        if(SceneManager.GetActiveScene().buildIndex == 1){
            takeKopiOsudu = GameObject.FindGameObjectWithTag("Table").GetComponent<TakeKopiOsudu>();
        }   
    }

    void OnTriggerEnter2D(Collider2D collider)
    {
        if(collider.gameObject.CompareTag("ExitDoors") && takeKopiOsudu.readyToEscape == true){
            SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
        }
    }
}
