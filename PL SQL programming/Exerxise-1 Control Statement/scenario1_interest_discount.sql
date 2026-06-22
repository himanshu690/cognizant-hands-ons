-- File: scenario1_interest_discount.sql
-- Exercise 1 - Scenario 1
-- Reduce loan interest rate by 1% for customers older than 60.

SET SERVEROUTPUT ON;

BEGIN
    FOR customer_rec IN
    (
        SELECT CustomerID,
               Name,
               TRUNC(MONTHS_BETWEEN(SYSDATE, DOB) / 12) AS Age
        FROM Customers
    )
    LOOP
        IF customer_rec.Age > 60 THEN

            UPDATE Loans
            SET InterestRate = InterestRate - 1
            WHERE CustomerID = customer_rec.CustomerID;

            DBMS_OUTPUT.PUT_LINE(
                'Updated loan interest for ' ||
                customer_rec.Name
            );

        END IF;
    END LOOP;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Interest rate update completed.');

END;
/