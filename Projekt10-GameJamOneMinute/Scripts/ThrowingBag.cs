using UnityEngine;
using System.Collections;

public class ThrowingBag : MonoBehaviour
{
    [Header("MoneyBag")]
    public GameObject moneyBag;
    public GameObject playerMoneyBag;
    public Transform armPos;

    public PlayerMovement playerMovement;

    public float throwingDirection;

    [Space][Space]

    public bool moneyBagIsPlaced;

    public bool isThrowing;

    void Awake()
    {
        playerMovement = GameObject.FindGameObjectWithTag("Player").GetComponent<PlayerMovement>();
    }

    void Update()
    {
        if(Input.GetKeyDown(KeyCode.E)){
            if(!moneyBagIsPlaced){
                isThrowing = true;
                moneyBagIsPlaced = true;
                HidePlayerMoneyBag();
                FindObjectOfType<AudioManager>().Play("ThrowingMoneyBag");
                Instantiate(moneyBag, armPos.position, Quaternion.identity);
            }   
        } else if(Input.GetKeyUp(KeyCode.E)){
            playerMovement.playerWalkingAnim.SetBool("IsThrowing", false);
        }


        if(isThrowing){
            playerMovement.playerWalkingAnim.SetBool("IsThrowing", true);
            isThrowing = false;
        }

        if(Input.GetKeyDown(KeyCode.A) || Input.GetKeyDown(KeyCode.LeftArrow)){
            throwingDirection = -1f;
        }
        if(Input.GetKeyDown(KeyCode.D) || Input.GetKeyDown(KeyCode.RightArrow)){
            throwingDirection = 1f;
        }
    }

    public void HidePlayerMoneyBag()
    {
        playerMoneyBag.SetActive(false);
    }

    public void ShowPlayerMoneyBag()
    {
        playerMoneyBag.SetActive(true);
    }
}
