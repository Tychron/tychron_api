defmodule Tychron.API.V1.CartsTest do
  use Tychron.Support.APICase

  alias Tychron.API.V1.Carts

  describe "create_cart/2" do
    test "can send a cart creation request", %{bypass: bypass} do
      cart_id = Ecto.ULID.generate()

      Bypass.expect(bypass, "POST", "/api/v1/carts", fn conn ->
        {:ok, doc, conn} = handle_json_request(conn)

        %{
          "type" => "cart",
          "data" => %{
            "name" => name,
            "notes" => notes,
          }
        } = doc
        send_json_resp(conn, 201, make_cart_body(id: cart_id, name: name, notes: notes))
      end)

      assert {:ok, %Tychron.M.DocumentResponse{
        response: %{status_code: 201},
        document: %Tychron.M.Document{
          type: "cart",
          data: %Tychron.M.Cart{
            id: ^cart_id,
            inserted_at: _,
            updated_at: _,
            name: "My Cart",
            notes: "My Notes",
          }
        }
      }} = Carts.create_cart(%{
        name: "My Cart",
        notes: "My Notes",
      })
    end
  end

  describe "list_carts/1" do
    test "can retrieve a cart by id", %{bypass: bypass} do
      cart_id = Ecto.ULID.generate()

      Bypass.expect(bypass, "GET", "/api/v1/carts", fn conn ->
        send_json_resp(conn, 200, make_page_result(Enum.map(1..10, fn _ ->
          make_cart_body(id: cart_id)
        end)))
      end)

      assert {:ok, %Tychron.M.PageResponse{
        response: %{status_code: 200},
        page_result: %Tychron.M.PageResult{
          count: 10,
          results: [
            %Tychron.M.Document{
              type: "cart",
              data: %Tychron.M.Cart{
                id: ^cart_id,
                inserted_at: _,
                updated_at: _,
                name: "A Cart",
                notes: "Some notes",
              }
            }
            | _
          ]
        }
      }} = Carts.list_carts(%{
        first: 20,
      })
    end
  end

  describe "get_cart/1" do
    test "can retrieve a cart by id", %{bypass: bypass} do
      cart_id = Ecto.ULID.generate()

      Bypass.expect(bypass, "GET", "/api/v1/carts/#{cart_id}", fn conn ->
        send_json_resp(conn, 200, make_cart_body(id: cart_id))
      end)

      assert {:ok, %Tychron.M.DocumentResponse{
        response: %{status_code: 200},
        document: %Tychron.M.Document{
          type: "cart",
          data: %Tychron.M.Cart{
            id: ^cart_id,
            inserted_at: _,
            updated_at: _,
            name: "A Cart",
            notes: "Some notes",
          }
        }
      }} = Carts.get_cart(cart_id)
    end
  end

  defp make_cart_body(options \\ []) do
    timestamp = DateTime.utc_now()

    %{
      "type" => "cart",
      "data" => %{
        "id" => Keyword.get_lazy(options, :id, fn ->
          Ecto.ULID.generate()
        end),
        "inserted_at" => timestamp,
        "updated_at" => timestamp,
        "name" => Keyword.get(options, :name, "A Cart"),
        "notes" => Keyword.get(options, :notes, "Some notes"),
      }
    }
  end
end
