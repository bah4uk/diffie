class HomeController < ApplicationController
  def index
  end

  def helpers
    @result = ''
    @solution = ''
  end

  def modulo
    num = params[:num].to_i
    e = params[:e].to_i
    m = params[:m].to_i
    @result = num.mod_exp(e, m)
    @solution = "#{num} ^ #{e} mod #{m} = #{@result}"
    render :action => :helpers
  end

  def dh_calculate
    a = params[:a].to_i
    b = params[:b].to_i
    p = params[:p].to_i
    g = params[:g].to_i
    aa = g.mod_exp(a,p)
    bb = g.mod_exp(b,p)
    key_a = bb.mod_exp(a,p)
    key_b = aa.mod_exp(b,p)

    alice = DH.new(p,g,a)
    bob   = DH.new(p,g,b)

    alice.generate
    bob.generate

    alice_s = alice.secret(bob.e)
    bob_s   = bob.secret(alice.e)

    @secrets = [alice_s, bob_s]

    @history = ["p = #{p}",
                "g = #{g}",
                "a = #{a}",
                "A = g^a mod p = #{g**a} mod #{p} = #{aa}",
                "b = #{b}",
                "B = g^b mod p = #{g**b} mod #{p} = #{bb}",
                "Alice & Bob exchange A and B",
                "key[a] = B^a mod p = #{bb**a} mod #{p} = #{key_a}",
                "key[b] = A^b mod p = #{aa**b} mod #{p} = #{key_b}"
               ]
    render :action => :diffie_hellman
  end

  def diffie_hellman
    @history = []
    @secrets = []
  end
end
