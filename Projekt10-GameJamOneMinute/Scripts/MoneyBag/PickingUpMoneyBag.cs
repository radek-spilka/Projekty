using UnityEngine;

public class PickingUpMoneyBag : MonoBehaviour
{
    private ThrowingBag throwingBag;

    void Awake()
    {
        throwingBag = GameObject.FindGameObjectWithTag("Player").GetComponent<ThrowingBag>();
    }

    void OnCollisionEnter2D(Collision2D collider)
    {
        if(collider.gameObject.CompareTag("Player")){
            FindObjectOfType<AudioManager>().Play("PickingUpMoneyBag");
            Destroy(gameObject);
            throwingBag.moneyBagIsPlaced = false;
            throwingBag.ShowPlayerMoneyBag();
        }
    }
}
