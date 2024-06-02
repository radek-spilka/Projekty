using UnityEngine;

public class MoneyBagFlies : MonoBehaviour
{
    private Rigidbody2D moneyBagRB;
    private ThrowingBag throwingBag;

    [Space]

    [Header("MoneyBag Stats")]
    public float throwingSpeed;
    public float throwingHeight;
    
    void Awake()
    {
        moneyBagRB = GetComponent<Rigidbody2D>();
        throwingBag = GameObject.FindGameObjectWithTag("Player").GetComponent<ThrowingBag>();
    }

    void Start()
    {
        moneyBagRB.velocity = new Vector2(throwingSpeed * throwingBag.throwingDirection, throwingHeight);
    }
}
