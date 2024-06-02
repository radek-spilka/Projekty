using UnityEngine;
using TMPro;

public class PickingUpGold : MonoBehaviour
{
    private TMP_Text goldCount_text;
    static int goldCount;

    private ThrowingBag throwingBag;

    void Awake()
    {
        throwingBag = GameObject.FindGameObjectWithTag("Player").GetComponent<ThrowingBag>();
        goldCount_text = GameObject.FindGameObjectWithTag("GoldCount").GetComponent<TMP_Text>();
        goldCount_text.text = "Gold: 0/3";
        goldCount = 0;
    }

    void OnTriggerEnter2D(Collider2D collider)
    {
        if(collider.gameObject.CompareTag("Player") && throwingBag.moneyBagIsPlaced == false){
            FindObjectOfType<AudioManager>().Play("PickingUpGolds");
            goldCount++;
            Destroy(gameObject);
        }
    }

    void Update()
    {
        if(goldCount == 0){
            goldCount_text.text = "Gold: 0/3";
        }if(goldCount == 1){
            goldCount_text.text = "Gold: 1/3";
        }if(goldCount == 2){
            goldCount_text.text = "Gold: 2/3";
        }if(goldCount == 3){
            goldCount_text.text = "Gold: 3/3";
        }
    }
}
