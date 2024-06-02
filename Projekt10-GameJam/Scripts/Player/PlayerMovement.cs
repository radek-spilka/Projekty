using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayerMovement : MonoBehaviour
{
    private Rigidbody2D theRB;
    private PauseMenu pauseMenu;

    [Header("Player Stats")]
    public float jumpForce;
    public float downForce;
    public float moveSpeed;
    private float moveInput;

    [Space]

    [SerializeField] LayerMask whatIsGround;
    private bool isGrounded;
    public Transform feetPos;
    public float checkRadius;

    [Space]

    public Animator playerWalkingAnim;

    private float hangTime = 0.1f;
    private float hangCounter;

    [Space]

    private bool facingRight = true;

    [Header("Footsteps Audio")]
    public Transform playerStayTransform;
    public bool facingRight2 = true;

    [Header("Footsteps Audio")]
    public bool isWalking;
    public GameObject AudioFootsteps;

    void Awake()
    {
        theRB = GetComponent<Rigidbody2D>();
        if(SceneManager.GetActiveScene().buildIndex == 1){
            pauseMenu = GameObject.FindGameObjectWithTag("Canvas").GetComponent<PauseMenu>();
        }
    }

    void Update()
    {
        moveInput = Input.GetAxis("Horizontal");

        isGrounded = Physics2D.OverlapCircle(feetPos.position, checkRadius, whatIsGround);

        if(Input.GetKeyDown(KeyCode.Space) && hangCounter > 0f){
            FindObjectOfType<AudioManager>().Play("Jump");
            theRB.velocity = Vector2.up * jumpForce;
        }if(Input.GetKeyDown(KeyCode.W) && hangCounter > 0f){
            FindObjectOfType<AudioManager>().Play("Jump");
            theRB.velocity = Vector2.up * jumpForce;
        }if(Input.GetKeyDown(KeyCode.UpArrow) && hangCounter > 0f){
            FindObjectOfType<AudioManager>().Play("Jump");
            theRB.velocity = Vector2.up * jumpForce;
        }

        if(Input.GetKeyUp(KeyCode.Space) && theRB.velocity.y > 0f){
            theRB.velocity = new Vector2(theRB.velocity.x, theRB.velocity.y * downForce);
        }if(Input.GetKeyUp(KeyCode.W) && theRB.velocity.y > 0f){
            theRB.velocity = new Vector2(theRB.velocity.x, theRB.velocity.y * downForce);
        }if(Input.GetKeyUp(KeyCode.UpArrow) && theRB.velocity.y > 0f){
            theRB.velocity = new Vector2(theRB.velocity.x, theRB.velocity.y * downForce);
        }

        if(Input.GetAxisRaw("Horizontal") != 0){
            playerWalkingAnim.SetBool("IsWalking", true);
            isWalking = true;
        } else if(Input.GetAxisRaw("Horizontal") == 0){
            playerWalkingAnim.SetBool("IsWalking", false);
            isWalking = false;
        }

        if(SceneManager.GetActiveScene().buildIndex == 1)
        {
            if(isWalking){
                AudioFootsteps.SetActive(true);
            } if(!isWalking){
                AudioFootsteps.SetActive(false);
            }
        }
        

        if(isGrounded){
            hangCounter = hangTime;
        } else {
            hangCounter -= Time.deltaTime;
        }

        if(SceneManager.GetActiveScene().buildIndex == 1){
            if(moveInput < 0 && facingRight && pauseMenu.pauseMenuUI.activeSelf == false){
                Flip();
            } else if(moveInput > 0 && !facingRight && pauseMenu.pauseMenuUI.activeSelf == false){
                Flip();
            }

            if(moveInput < 0 && facingRight2){
                FlipPlayerStay();
            } else if(moveInput > 0 && !facingRight2){
                FlipPlayerStay();
            }
        }

        if(moveInput < 0 && facingRight){
            Flip();
        } else if(moveInput > 0 && !facingRight){
            Flip();
        }
        
    }

    void FixedUpdate()
    {
        theRB.velocity = new Vector2(moveInput * moveSpeed, theRB.velocity.y);
    }

    void Flip()
    {
        facingRight = !facingRight;

        transform.Rotate(0f, 180f, 0f);
    }

    void FlipPlayerStay()
    {
        facingRight2 = !facingRight2;

        playerStayTransform.Rotate(0f, 180f, 0);
    }
}
