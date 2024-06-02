using UnityEngine;
using UnityEngine.SceneManagement;

public class ElevatorButton : MonoBehaviour
{
    private Animator buttonAnim;
    private Animator buttonAnim2;
    private Animator elevatorAnim;

    public bool buttonIsPressed;

    void Awake()
    {
        if(SceneManager.GetActiveScene().buildIndex == 1){
            buttonAnim = GameObject.FindGameObjectWithTag("ElevatorButton").GetComponent<Animator>();
            buttonAnim2 = GameObject.FindGameObjectWithTag("ElevatorButton2").GetComponent<Animator>();
            elevatorAnim = GameObject.FindGameObjectWithTag("Elevator").GetComponent<Animator>();
        }

    }

    void OnTriggerEnter2D(Collider2D collider)
    {
        if(collider.CompareTag("ElevatorButton")){
            buttonAnim.SetBool("IsPressed", true);
            elevatorAnim.SetBool("IsPressed", true);
            buttonIsPressed = true;
            FindObjectOfType<AudioManager>().Play("ButtonPressed");
        }

        if(collider.CompareTag("ElevatorButton2")){
            buttonAnim2.SetBool("IsPressed", true);
            elevatorAnim.SetBool("IsPressed2", true);
            buttonIsPressed = true;
            FindObjectOfType<AudioManager>().Play("ButtonPressed");
        }
    }
}
